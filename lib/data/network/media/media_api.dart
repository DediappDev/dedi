import 'dart:io';

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

  Future<int> _resolveStableFileLength(
    File file, {
    int maxAttempts = 8,
    Duration step = const Duration(milliseconds: 120),
  }) async {
    var current = await file.length();
    if (current <= 0) return current;
    for (var i = 0; i < maxAttempts; i++) {
      await Future.delayed(step);
      final next = await file.length();
      if (next == current) {
        return next;
      }
      current = next;
    }
    return current;
  }

  Future<UploadFileResponse> uploadFileMobile({
    required FileInfo fileInfo,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
  }) async {
    final file = File(fileInfo.filePath);
    final hasLocalFile = fileInfo.filePath.isNotEmpty && await file.exists();
    final contentLength = hasLocalFile
        ? await _resolveStableFileLength(file)
        : fileInfo.fileSize;
    if (contentLength <= 0) {
      throw ArgumentError(
        'uploadFileMobile(): invalid content length for ${fileInfo.filePath}',
      );
    }

    final dioHeaders = _client.getHeaders();
    dioHeaders[HttpHeaders.contentLengthHeader] = contentLength;
    dioHeaders[HttpHeaders.contentTypeHeader] = fileInfo.mimeType;

    final requestBody =
        hasLocalFile ? file.openRead(0, contentLength) : fileInfo.readStream;
    if (requestBody == null) {
      throw ArgumentError(
        'uploadFileMobile(): missing upload stream for ${fileInfo.filePath}',
      );
    }

    final response = await _client
        .postToGetBody(
      HomeserverEndpoint.uploadMediaServicePath
          .generateHomeserverMediaEndpoint(),
      data: requestBody,
      queryParameters: {
        'fileName': fileInfo.fileName,
      },
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      options: Options(headers: dioHeaders),
    )
        .onError((error, stackTrace) {
      if (error is DioException && error.type == DioExceptionType.cancel) {
        throw CancelRequestException();
      }
      if (error is DioException) {
        Logs().e(
          'uploadFileMobile() failed: ${error.response?.statusCode} ${error.response?.data}',
          error,
          stackTrace,
        );
      }
      if (error is Object) {
        throw error;
      }
      throw Exception('uploadFileMobile(): unknown upload error');
    });

    return UploadFileResponse.fromJson(response);
  }

  Future<UploadFileResponse> uploadFileWeb({
    required MatrixFile file,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
  }) async {
    final contentLength = file.bytes?.length ?? file.size;
    if (contentLength <= 0) {
      throw ArgumentError(
        'uploadFileWeb(): invalid content length for ${file.name}',
      );
    }

    final dioHeaders = _client.getHeaders();
    dioHeaders[HttpHeaders.contentLengthHeader] = contentLength;
    dioHeaders[HttpHeaders.contentTypeHeader] = file.mimeType;
    final response = await _client
        .postToGetBody(
      HomeserverEndpoint.uploadMediaServicePath
          .generateHomeserverMediaEndpoint(),
      data: file.bytes,
      queryParameters: {
        'fileName': file.name,
      },
      onSendProgress: onSendProgress,
      cancelToken: cancelToken,
      options: Options(headers: dioHeaders),
    )
        .onError((error, stackTrace) {
      if (error is DioException && error.type == DioExceptionType.cancel) {
        throw CancelRequestException();
      }
      if (error is DioException) {
        Logs().e(
          'uploadFileWeb() failed: ${error.response?.statusCode} ${error.response?.data}',
          error,
          stackTrace,
        );
      }
      if (error is Object) {
        throw error;
      }
      throw Exception('uploadFileWeb(): unknown upload error');
    });

    return UploadFileResponse.fromJson(response);
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
        throw Exception(error);
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
        throw Exception(error);
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
    ).onError((error, stackTrace) => throw Exception(error));

    return UrlPreviewResponse.fromJson(response);
  }
}
