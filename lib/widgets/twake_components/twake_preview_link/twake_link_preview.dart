import 'package:fluffychat/domain/app_state/preview_url/get_preview_url_success.dart';
import 'package:fluffychat/pages/chat/events/formatted_text_widget.dart';
import 'package:fluffychat/presentation/extensions/media/url_preview_extension.dart';
import 'package:fluffychat/presentation/mixins/linkify_mixin.dart';
import 'package:fluffychat/utils/string_extension.dart';
import 'package:fluffychat/widgets/mixins/get_preview_url_mixin.dart';
import 'package:fluffychat/widgets/twake_components/twake_preview_link/twake_link_preview_item.dart';
import 'package:fluffychat/widgets/twake_components/twake_preview_link/twake_link_preview_item_style.dart';
import 'package:fluffychat/widgets/twake_components/twake_preview_link/twake_link_view.dart';
import 'package:flutter/material.dart';
import 'package:linagora_design_flutter/linagora_design_flutter.dart';
import 'package:linkfy_text/linkfy_text.dart';
import 'package:matrix/matrix.dart' hide Visibility;
import 'package:skeletonizer/skeletonizer.dart';

class DediLinkPreview extends StatefulWidget {
  final Event event;
  final String localizedBody;
  final bool ownMessage;
  final double fontSize;
  final TextStyle? linkStyle;
  final TextStyle? richTextStyle;

  const DediLinkPreview({
    super.key,
    required this.event,
    required this.localizedBody,
    required this.ownMessage,
    required this.fontSize,
    this.linkStyle,
    this.richTextStyle,
  });

  @override
  State<DediLinkPreview> createState() => DediLinkPreviewController();
}

class DediLinkPreviewController extends State<DediLinkPreview>
    with GetPreviewUrlMixin, AutomaticKeepAliveClientMixin, LinkifyMixin {
  String? get firstValidUrl => widget.localizedBody.getFirstValidUrl();

  Uri get uri => Uri.parse(firstValidUrl ?? '');

  static const dediLinkViewKey = ValueKey('DediLinkPreviewKey');

  static const dediLinkPreviewItemKey = ValueKey('DediLinkPreviewItemKey');

  @override
  String debugLabel = 'DediLinkPreviewController';

  @override
  void initState() {
    if (firstValidUrl != null) {
      getPreviewUrl(uri: uri);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DediLinkView(
      key: dediLinkViewKey,
      firstValidUrl: firstValidUrl,
      body: widget.event.formattedText.isNotEmpty
          ? FormattedTextWidget(
              event: widget.event,
              linkStyle: widget.linkStyle,
              fontSize: widget.fontSize,
            )
          : MatrixLinkifyText(
              text: widget.localizedBody,
              textStyle: widget.richTextStyle,
              linkStyle: widget.linkStyle,
              linkTypes: const [
                LinkType.url,
                LinkType.phone,
              ],
              textAlign: TextAlign.start,
              onTapDownLink: (tapDownDetails, link) => handleOnTappedLinkHtml(
                context: context,
                details: tapDownDetails,
                link: link,
              ),
            ),
      previewItemWidget: ValueListenableBuilder(
        valueListenable: getPreviewUrlStateNotifier,
        builder: (context, state, child) {
          return state.fold(
            (failure) => const SizedBox.shrink(),
            (success) {
              if (success is GetPreviewUrlSuccess) {
                final previewLink = success.urlPreview.toPresentation();
                return DediLinkPreviewItem(
                  key: dediLinkPreviewItemKey,
                  ownMessage: widget.ownMessage,
                  urlPreviewPresentation: previewLink,
                  previewLink: firstValidUrl,
                );
              }
              return child!;
            },
          );
        },
        child: Skeletonizer.zone(
          child: Container(
            constraints: const BoxConstraints(
              minWidth: double.infinity,
            ),
            height: DediLinkPreviewItemStyle.maxHeightPreviewItem,
            decoration: ShapeDecoration(
              color: widget.ownMessage
                  ? DediRefColors.material().primary[95]
                  : DediStateLayer(
                      DediSysColors.material().surfaceTint,
                    ).opacityLayer1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  DediLinkPreviewItemStyle.radiusBorder,
                ),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Bone.button(
                  width: DediLinkPreviewItemStyle.heightMxcImagePreview,
                  height: DediLinkPreviewItemStyle.heightMxcImagePreview,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(
                      DediLinkPreviewItemStyle.radiusBorder,
                    ),
                    bottom: Radius.circular(
                      DediLinkPreviewItemStyle.radiusBorder,
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
                        child: Column(
                          children: [
                            Bone.text(
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            DediLinkPreviewItemStyle.skeletonizerTextPadding,
                            Bone.text(
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        key: LinkPreviewBuilder.paddingSubtitleKey,
                        padding: DediLinkPreviewItemStyle.paddingSubtitle,
                        child: Column(
                          children: [
                            Bone.text(
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            DediLinkPreviewItemStyle.skeletonizerTextPadding,
                            Bone.text(
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
