import 'package:flutter_animate/flutter_animate.dart';
import 'package:jokes/helper/app_constants.dart';
import 'package:jokes/main.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    Key? key,
    this.bg = AppConstants.accentColor,
    this.radius = 4.0,
    this.textColor = AppConstants.white,
    required this.onTap,
    this.text,
    this.style,
    this.shadow = false,
    this.height = 48.0,
    this.showBorder = false,
    this.showLoading = false,
    this.showMargin = true,
    this.borderColor = AppConstants.black,
    this.controller,
  }) : super(key: key);

  final Color bg;
  final Color textColor;
  final Color borderColor;
  final double radius;
  final String? text;
  final bool shadow;
  final bool showMargin;
  final bool showBorder;
  final bool showLoading;
  final double height;
  final TextStyle? style;
  final GestureTapCallback? onTap;
  final AnimationController? controller;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool buttonTapped = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 40.0,
        left: 12.0,
        right: 12.0,
      ),
      child: Transform.scale(
        // origin:
        //     buttonTapped ? const Offset(-4.0, -4.0) : const Offset(0.0, 0.0),
        scale: buttonTapped ? 0.9 : 1.0,
        child: Ink(
          decoration: BoxDecoration(
            color: widget.bg,
            borderRadius: BorderRadius.circular(widget.radius),
            boxShadow: widget.shadow
                ? [
                    BoxShadow(
                      offset: !buttonTapped
                          ? const Offset(0.0, 0.0)
                          : const Offset(0.0, 4.0),
                      color: AppConstants.black.withOpacity(0.9),
                    ),
                  ]
                : null,
          ),
          child: InkWell(
            onTap: widget.onTap,
            onTapDown: (x) {
              setState(() {
                buttonTapped = true;
              });
            },
            onTapUp: (x) {
              setState(() {
                buttonTapped = false;
              });
            },
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.radius),
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              // decoration: BoxDecoration(
              //   color: bg,
              //   borderRadius: BorderRadius.circular(radius),
              //   boxShadow: shadow
              //       ? [
              //           BoxShadow(
              //             offset: const Offset(1.0, 5.0),
              //             color: AppConstants.black.withOpacity(0.1),
              //             blurRadius: 8.0,
              //             spreadRadius: 3.0,
              //           ),
              //         ]
              //       : null,
              // ),
              alignment: Alignment.bottomCenter,
              child: InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.text!,
                      style: widget.style != null
                          ? widget.style!
                          : context.customStyle(
                              size: 16.0,
                              color: context.white(),
                              fontWeight: FontWeight.bold,
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    )
        .animate(
          controller: widget.controller,
        )
        .fadeIn(
          duration: 350.ms,
        );
  }
}
