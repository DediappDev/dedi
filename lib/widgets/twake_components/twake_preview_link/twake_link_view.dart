import 'package:fluffychat/widgets/twake_components/twake_preview_link/twake_link_view_style.dart';
import 'package:flutter/material.dart';

class DediLinkView extends StatelessWidget {
  final Widget body;
  final Widget previewItemWidget;
  final String? firstValidUrl;

  const DediLinkView({
    super.key,
    required this.body,
    required this.previewItemWidget,
    this.firstValidUrl,
  });

  @override
  Widget build(BuildContext context) {
    if (firstValidUrl == null) {
      return _buildMessageBody(context);
    }

    return _buildMessageWithPreview(context);
  }

  Widget _buildMessageWithPreview(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: DediLinkViewStyle.previewItemPadding,
          child: previewItemWidget,
        ),
        const SizedBox(height: DediLinkViewStyle.previewToBodySpacing),
        _buildMessageBody(context),
      ],
    );
  }

  Widget _buildMessageBody(BuildContext context) {
    return Padding(
      padding: DediLinkViewStyle.paddingMessageBody,
      child: body,
    );
  }
}
