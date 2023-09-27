import 'package:flutter/material.dart';
import 'package:jokes/helper/app_constants.dart';

class Dot extends StatelessWidget {
  final Color? color;
  const Dot({
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color ?? darkGreyColor,
      ),
    );
  }
}
