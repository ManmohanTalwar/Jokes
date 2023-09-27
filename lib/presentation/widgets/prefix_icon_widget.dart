import 'package:flutter/material.dart';
import 'package:jokes/helper/app_constants.dart';
import 'package:jokes/main.dart';

class PrefixIconWidget extends StatelessWidget {
  final IconData? icon;
  final bool isImage;
  const PrefixIconWidget({
    super.key,
    this.icon,
    this.isImage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isImage ? 6.0 : 12.0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isImage) ...{
            Image.asset(
              'assets/images/parcel_icon.jpg',
              width: 25.0,
            ),
          } else ...{
            Icon(
              icon,
              color: context.greyTextColor(),
            ),
            const SizedBox(
              width: 8.0,
            ),
            VerticalDivider(
              width: 1.0,
              thickness: 1.2,
              color: isImage
                  ? context.darkTextColor()
                  : context.greyTextColor().withOpacity(0.5),
              endIndent: 12.0,
              indent: 12.0,
            ),
          },
        ],
      ),
    );
  }
}
