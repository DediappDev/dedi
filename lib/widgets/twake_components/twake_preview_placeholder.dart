import 'package:flutter/material.dart';
import 'package:linagora_design_flutter/linagora_design_flutter.dart';

class DediPreviewPlaceHolder extends StatelessWidget {
  const DediPreviewPlaceHolder({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 12,
  });

  final double width;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: DediRefColors.material().primary[95],
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
