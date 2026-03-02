import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/config/app_config.dart';
import 'package:fluffychat/data/network/media/media_api.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/domain/app_state/room/upload_content_state.dart';
import 'package:fluffychat/domain/exception/room/can_not_upload_content_exception.dart';
import 'package:fluffychat/presentation/model/file/file_asset_entity.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:matrix/matrix.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

class UploadContentInteractor {
  final mediaApi = getIt.get<MediaAPI>();

  Future<ImageFileInfo?> _compressAvatarToFit({
    required ImageFileInfo original,
    required int maxBytes,
  }) async {
    final tempDir = Directory.systemTemp;
    const qualitySteps = [85, 70, 55, 40, 30];
    for (final quality in qualitySteps) {
      final targetPath =
          '${tempDir.path}/avatar_${DateTime.now().microsecondsSinceEpoch}_q$quality.jpg';
      final compressed = await FlutterImageCompress.compressAndGetFile(
        original.filePath,
        targetPath,
        quality: quality,
        format: AppConfig.imageCompressFormmat,
        minWidth: 1024,
        minHeight: 1024,
      );
      if (compressed == null) continue;
      final size = await compressed.length();
      if (size <= maxBytes) {
        return ImageFileInfo(
          compressed.path.split('/').last,
          compressed.path,
          size,
          width: original.width,
          height: original.height,
        );
      }
    }
    return null;
  }

  Stream<Either<Failure, Success>> execute({
    required Client matrixClient,
    required AssetEntity entity,
  }) async* {
    try {
      yield Right(UploadContentLoading());
      final contentEntity = FileAssetEntity.createAssetEntity(entity);
      final contentFileInfo = await contentEntity.toFileInfo();
      final mediaConfig = await matrixClient.getConfig();
      final maxMediaSize = mediaConfig.mUploadSize;
      if (contentFileInfo != null) {
        FileInfo uploadFileInfo = contentFileInfo;
        var fileSize = uploadFileInfo.fileSize;
        if (maxMediaSize != null &&
            fileSize > maxMediaSize &&
            uploadFileInfo is ImageFileInfo) {
          final compressed = await _compressAvatarToFit(
            original: uploadFileInfo,
            maxBytes: maxMediaSize,
          );
          if (compressed != null) {
            uploadFileInfo = compressed;
            fileSize = compressed.fileSize;
            Logs().i(
              'UploadContentInteractor::execute(): avatar compressed to $fileSize bytes',
            );
          }
        }

        Logs().d(
          'UploadContentInteractor::execute(): FileSized $fileSize || maxMediaSize $maxMediaSize',
        );
        if (maxMediaSize != null && maxMediaSize < fileSize) {
          yield Left(
            FileTooBigMatrix(
              FileTooBigMatrixException(fileSize, maxMediaSize),
            ),
          );
          return;
        }

        final response = await mediaApi.uploadFileMobile(fileInfo: uploadFileInfo);

        if (response.contentUri != null) {
          final contentUri = Uri.parse(response.contentUri!);
          yield Right(UploadContentSuccess(uri: contentUri));
        } else {
          yield Left(
            UploadContentFailed(exception: CannotUploadContentException()),
          );
        }
      } else {
        yield Left(
          UploadContentFailed(exception: CannotUploadContentException()),
        );
      }
    } catch (exception) {
      Logs().e('UploadContentInteractor::execute() failed', exception);
      yield Left(UploadContentFailed(exception: exception));
    }
  }
}
