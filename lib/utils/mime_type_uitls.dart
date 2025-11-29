import 'package:fluffychat/domain/model/preview_file/supported_preview_file_types.dart';
import 'package:fluffychat/utils/extension/mime_type_extension.dart';
import 'package:mime/mime.dart';

class MimeTypeUitls {
  MimeTypeUitls._();

  static MimeTypeUitls get instance => MimeTypeUitls._();

  String getDediMimeType(String path) {
    final mimeType = lookupMimeType(path);
    if (mimeType == null) {
      return 'application/octet-stream';
    }
    if (mimeType.startsWith('image/')) {
      if (SupportedPreviewFileTypes.crossPlatformImageMimeTypes
          .contains(mimeType)) {
        return mimeType;
      } else {
        return DediMimeTypeExtension.defaultUnsupportedImageMimeType;
      }
    } else if (mimeType.startsWith('video/')) {
      if (SupportedPreviewFileTypes.videoMimeTypes.contains(mimeType)) {
        return mimeType;
      } else {
        return DediMimeTypeExtension.defaultUnsupportedVideoMimeType;
      }
    } else {
      return mimeType;
    }
  }
}
