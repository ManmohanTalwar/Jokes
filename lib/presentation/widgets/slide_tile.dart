import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SlideTile extends StatelessWidget {
  final String? imagePath, title, desc;
  const SlideTile({
    Key? key,
    this.imagePath,
    this.title,
    this.desc,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Lottie.asset(
        imagePath!,
        fit: BoxFit.fill,
      ),
    );
  }
}
