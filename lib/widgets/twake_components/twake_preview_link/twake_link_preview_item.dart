import 'package:fluffychat/presentation/model/media/url_preview_presentation.dart';
import 'package:fluffychat/utils/url_launcher.dart';
import 'package:fluffychat/widgets/mxc_image.dart';
import 'package:fluffychat/widgets/twake_components/twake_preview_link/twake_link_preview_item_style.dart';
import 'package:flutter/material.dart';
import 'package:linagora_design_flutter/linagora_design_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DediLinkPreviewItem extends StatelessWidget {
  final bool ownMessage;
  final UrlPreviewPresentation urlPreviewPresentation;
  final String? previewLink;

  const DediLinkPreviewItem({
    super.key,
    required this.ownMessage,
    required this.urlPreviewPresentation,
    this.previewLink,
  });

  static const linkPreviewBodyKey = ValueKey('DediLinkPreviewBodyKey');

  static const linkPreviewLargeKey = ValueKey('LinkPreviewLargeKey');

  @override
  Widget build(BuildContext context) {
    return Container(
      key: linkPreviewBodyKey,
      constraints: const BoxConstraints(
        minWidth: double.infinity,
      ),
      height: DediLinkPreviewItemStyle.maxHeightPreviewItem,
      decoration: ShapeDecoration(
        color: ownMessage
            ? DediSysColors.material().primaryContainer
            : DediSysColors.material().onSurface.withOpacity(0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            DediLinkPreviewItemStyle.radiusBorder,
          ),
        ),
      ),
      child: InkWell(
        onTap: () {
          if (previewLink == null) return;
          UrlLauncher(context, url: previewLink).launchUrl();
        },
        child: LinkPreviewBuilder(
          key: linkPreviewLargeKey,
          urlPreviewPresentation: urlPreviewPresentation,
          previewLink: previewLink,
        ),
      ),
    );
  }
}

class LinkPreviewBuilder extends StatelessWidget {
  const LinkPreviewBuilder({
    super.key,
    required this.urlPreviewPresentation,
    this.previewLink,
  });

  final String? previewLink;

  final UrlPreviewPresentation urlPreviewPresentation;

  static const clipRRectKey = ValueKey('ClipRRectKey');

  static const mxcImageKey = ValueKey('MxcImageKey');

  static const paddingTitleKey = ValueKey('PaddingTitleKey');

  static const paddingSubtitleKey = ValueKey('PaddingSubtitleKey');

  static const titleKey = ValueKey('TextTitleKey');

  static const subtitleKey = ValueKey('TextSubtitleKey');

  static const imageDefaultKey = ValueKey('ImageDefaultKey');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (previewLink == null) return;
        UrlLauncher(context, url: previewLink).launchUrl();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            key: LinkPreviewBuilder.clipRRectKey,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(
                DediLinkPreviewItemStyle.radiusBorder,
              ),
              bottom: Radius.circular(
                DediLinkPreviewItemStyle.radiusBorder,
              ),
            ),
            child: SizedBox(
              width: DediLinkPreviewItemStyle.heightMxcImagePreview,
              height: DediLinkPreviewItemStyle.heightMxcImagePreview,
              child: (urlPreviewPresentation.imageUri != null &&
                      urlPreviewPresentation.imageWidth != null &&
                      urlPreviewPresentation.imageHeight != null)
                  ? MxcImage(
                      key: LinkPreviewBuilder.mxcImageKey,
                      uri: urlPreviewPresentation.imageUri,
                      height: MediaQuery.sizeOf(context).height,
                      width: MediaQuery.sizeOf(context).width,
                      fit: BoxFit.cover,
                      isThumbnail: false,
                      placeholder: (_) => const Skeletonizer.zone(
                        child: Bone.button(
                          width: DediLinkPreviewItemStyle.heightMxcImagePreview,
                          height:
                              DediLinkPreviewItemStyle.heightMxcImagePreview,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(
                              DediLinkPreviewItemStyle.radiusBorder,
                            ),
                            bottom: Radius.circular(
                              DediLinkPreviewItemStyle.radiusBorder,
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(
                      key: LinkPreviewBuilder.imageDefaultKey,
                      height: DediLinkPreviewItemStyle.heightMxcImagePreview,
                      child: Icon(
                        Icons.link,
                        size: DediLinkPreviewItemStyle.linkIconSize,
                      ),
                    ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  key: LinkPreviewBuilder.paddingTitleKey,
                  padding: DediLinkPreviewItemStyle.paddingTitle,
                  child: Text(
                    key: LinkPreviewBuilder.titleKey,
                    urlPreviewPresentation.title ?? '',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  key: LinkPreviewBuilder.paddingSubtitleKey,
                  padding: DediLinkPreviewItemStyle.paddingSubtitle,
                  child: Text(
                    key: LinkPreviewBuilder.subtitleKey,
                    urlPreviewPresentation.description ?? '',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: DediRefColors.material().neutral[50],
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
