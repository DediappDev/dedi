import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:fluffychat/data/model/media/download_file_response.dart';
import 'package:fluffychat/data/model/media/upload_file_json.dart';
import 'package:fluffychat/data/model/media/url_preview_response.dart';
import 'package:fluffychat/data/network/dio_client.dart';
import 'package:fluffychat/data/network/exception/dio_duplicate_download_exception.dart';
import 'package:fluffychat/data/network/homeserver_endpoint.dart';
import 'package:fluffychat/data/network/media/cancel_exception.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/di/global/network_di.dart';
import 'package:matrix/matrix.dart';

class MediaAPI {
  final DioClient _client =
      getIt.get<DioClient>(instanceName: NetworkDI.homeDioClientName);

  MediaAPI();

  Future<UploadFileResponse> uploadFileMobile({
    required FileInfo fileInfo,
    Client? matrixClient,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
  }) async {
    final dioHeaders = _client.getHeaders();
    dioHeaders[HttpHeaders.contentTypeHeader] = fileInfo.mimeType;
    final streamOnlyUploadBytes =
        fileInfo.filePath.isEmpty ? await _readFileBytes(fileInfo) : null;
    try {
      final response = await _client.postToGetBody(
        HomeserverEndpoint.uploadMediaServicePath
            .generateHomeserverMediaEndpoint(),
        data: streamOnlyUploadBytes ??
            fileInfo.readStream ??
            File(fileInfo.filePath).openRead(),
        queryParameters: {
          'filename': fileInfo.fileName,
        },
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        options: Options(headers: dioHeaders),
      );
      return UploadFileResponse.fromJson(response);
    } on DioException catch (error) {
      if (error.type == DioExceptionType.cancel) {
        throw CancelRequestException();
      }

      final shouldRetryWithBytes =
          error.response?.statusCode == 400 || _isContentLengthMismatch(error);
      if (shouldRetryWithBytes) {
        final fileBytes =
            streamOnlyUploadBytes ?? await _readFileBytes(fileInfo);
        if (fileBytes != null && fileBytes.isNotEmpty) {
          try {
            final response = await _client.postToGetBody(
              HomeserverEndpoint.uploadMediaServicePath
                  .generateHomeserverMediaEndpoint(),
              data: fileBytes,
              queryParameters: {
                'filename': fileInfo.fileName,
              },
              cancelToken: cancelToken,
              onSendProgress: onSendProgress,
              options: Options(headers: dioHeaders),
            );
            return UploadFileResponse.fromJson(response);
          } on DioException catch (retryError) {
            if (retryError.type == DioExceptionType.cancel) {
              throw CancelRequestException();
            }

            // Some homeserver deployments reject /_matrix/media/v3/upload.
            // Fallback to matrix client's upload implementation.
            if (retryError.response?.statusCode == 400 &&
                matrixClient != null) {
              final uri = await matrixClient.uploadContent(
                Uint8List.fromList(fileBytes),
                filename: fileInfo.fileName,
                contentType: fileInfo.mimeType,
              );
              return UploadFileResponse(contentUri: uri.toString());
            }
            rethrow;
          }
        }
      }

      rethrow;
    }
  }

  bool _isContentLengthMismatch(DioException error) {
    final errorText = error.error?.toString() ?? '';
    return errorText.contains('Content size exceeds specified contentLength');
  }

  Future<List<int>?> _readFileBytes(FileInfo fileInfo) async {
    if (fileInfo.filePath.isNotEmpty) {
      final file = File(fileInfo.filePath);
      if (await file.exists()) {
        return file.readAsBytes();
      }
    }

    final readStream = fileInfo.readStream;
    if (readStream != null) {
      final chunks = await readStream.toList();
      return chunks.expand((chunk) => chunk).toList();
    }

    return null;
  }

  Future<UploadFileResponse> uploadFileWeb({
    required MatrixFile file,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
  }) async {
    final dioHeaders = _client.getHeaders();
    dioHeaders[HttpHeaders.contentTypeHeader] = file.mimeType;
    try {
      final response = await _client.postToGetBody(
        HomeserverEndpoint.uploadMediaServicePath
            .generateHomeserverMediaEndpoint(),
        data: file.bytes,
        queryParameters: {
          'filename': file.name,
        },
        onSendProgress: onSendProgress,
        cancelToken: cancelToken,
        options: Options(headers: dioHeaders),
      );

      return UploadFileResponse.fromJson(response);
    } on DioException catch (error) {
      if (error.type == DioExceptionType.cancel) {
        throw CancelRequestException();
      }
      rethrow;
    }
  }

  Future<DownloadFileResponse> downloadFileInfo({
    required Uri uriPath,
    required String savePath,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    final response = await _client.download(
      uriPath,
      savePath: savePath,
      options: Options(
        headers: {HttpHeaders.acceptEncodingHeader: '*'}, // Disable gzip
      ),
      onReceiveProgress: (receive, total) {
        if (onReceiveProgress != null) {
          onReceiveProgress(receive, total);
        }
      },
      cancelToken: cancelToken,
    ).onError((error, stackTrace) {
      if (error is DioException && error.type == DioExceptionType.cancel) {
        throw CancelRequestException();
      } else if (error is DioDuplicateDownloadException) {
        Logs().i('downloadFileInfo error: $error');
        throw DioDuplicateDownloadException(
          requestOptions: error.requestOptions,
        );
      } else {
        Logs().i('downloadFileInfo error: $error');
        throw (error ?? Exception('Unknown download error'));
      }
    });

    return DownloadFileResponse(
      savePath: savePath,
      onReceiveProgress: onReceiveProgress,
      requestOptions: response.requestOptions,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      data: response.data,
      extra: response.extra,
      headers: response.headers,
      isRedirect: response.isRedirect,
      redirects: response.redirects,
    );
  }

  Future<Stream<List<int>>> downloadFileWeb({
    required Uri uri,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    final response = await _client
        .get(
      uri.path,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
      options: Options(
        responseType: ResponseType.stream,
      ),
    )
        .onError((error, stackTrace) {
      if (error is DioException && error.type == DioExceptionType.cancel) {
        throw CancelRequestException();
      } else {
        throw (error ?? Exception('Unknown download stream error'));
      }
    });

    return response.stream;
  }

  Future<UrlPreviewResponse> getUrlPreview({
    required Uri uri,
    int? preferredPreviewTime,
  }) async {
    final response = await _client.get(
      HomeserverEndpoint.getPreviewUrlServicePath
          .generateHomeserverMediaEndpoint(),
      queryParameters: {
        'url': uri.toString(),
        if (preferredPreviewTime != null) 'ts': preferredPreviewTime,
      },
    ).onError(
      (error, stackTrace) =>
          throw (error ?? Exception('Unknown url preview error')),
    );

    return UrlPreviewResponse.fromJson(response);
  }
}
