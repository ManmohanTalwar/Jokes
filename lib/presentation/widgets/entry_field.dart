import 'dart:io';

import 'package:jokes/helper/app_constants.dart';
import 'package:jokes/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EntryField extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? image;
  final String? initialValue;
  final bool? readOnly;
  final TextInputType? keyboardType;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final String? hint;
  final String? suffixIcon;
  final Icon? suffixIconData;
  final Function? onTap;
  final Function? onChanged;
  final TextCapitalization? textCapitalization;
  final GestureTapCallback? onSuffixPressed;
  final Function? onSubmitted;
  final bool showCountryCode;
  final bool obscureText;
  final bool showWithoutSpace;
  final bool giveColorOpacity;
  final String? text;
  final String? counterText;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final Color? suffixIconColor;
  final Color barColor;
  final bool validator;
  final String? errorText;
  final EdgeInsets? contentPadding;
  final Color hintColor;
  final Color textColor;
  final Color borderColor;
  final double radius;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final Color? bgColor;
  final FontWeight? hintWeight;

  const EntryField({
    Key? key,
    this.controller,
    this.label,
    this.image,
    this.initialValue,
    this.readOnly,
    this.keyboardType,
    this.maxLength,
    this.hint,
    this.suffixIcon,
    this.maxLines,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.text,
    this.textCapitalization,
    this.onSuffixPressed,
    this.showCountryCode = false,
    this.obscureText = false,
    this.showWithoutSpace = false,
    this.giveColorOpacity = true,
    this.focusNode,
    this.textInputAction,
    this.suffixIconColor,
    this.validator = false,
    this.barColor = Colors.black,
    this.hintColor = Colors.black,
    this.textColor = Colors.black,
    this.errorText,
    this.counterText,
    this.contentPadding,
    this.minLines = 1,
    this.borderColor = const Color(0xffE0E2E1),
    this.suffixIconData,
    this.radius = 8.0,
    this.prefixWidget,
    this.suffixWidget,
    this.bgColor,
    this.hintWeight,
  });

  @override
  _EntryFieldState createState() => _EntryFieldState();
}

class _EntryFieldState extends State<EntryField> {
  Color get suffixIconColor => widget.suffixIconColor ?? AppConstants.black;
  double get radius => widget.radius;
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        height: 50.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: widget.bgColor ?? Colors.white,
        ),
        child: TextFormField(
          style: context.customStyle(
            size: 14.0,
            fontWeight: FontWeight.normal,
            color: widget.textColor,
          ),
          focusNode: widget.focusNode,
          textCapitalization:
              widget.textCapitalization ?? TextCapitalization.sentences,
          cursorColor: context.primaryColor(),
          autofocus: false,
          onTap: widget.onTap as void Function()?,
          onFieldSubmitted: widget.onSubmitted as void Function(String)?,
          textInputAction: widget.textInputAction ?? TextInputAction.done,
          controller: widget.controller,
          onChanged: widget.onChanged as void Function(String)?,
          readOnly: widget.readOnly ?? false,
          keyboardType:
              Platform.isIOS ? TextInputType.text : widget.keyboardType,
          minLines: widget.minLines,
          initialValue: widget.initialValue,
          maxLength: widget.maxLength,
          maxLines: widget.maxLines ?? 1,
          obscureText: widget.obscureText,
          enableInteractiveSelection: false,
          cursorWidth: 1.2,
          decoration: InputDecoration(
            prefixText: widget.showCountryCode ? '+91 ' : null,
            errorText: widget.validator
                ? widget.errorText != null && widget.errorText!.isNotEmpty
                    ? widget.errorText
                    : ''
                : null,
            labelText: widget.label,
            counterText: widget.counterText,
            contentPadding: widget.contentPadding,
            labelStyle: AppConstants.customNormal(
              style: FontStyle.normal,
              weight: FontWeight.w500,
              size: 15.0,
              color: widget.hintColor.withOpacity(0.6),
            ),
            alignLabelWithHint: true,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.borderColor,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(radius),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: widget.borderColor, width: 1.0),
              borderRadius: BorderRadius.circular(radius),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.red,
              ),
              borderRadius: BorderRadius.circular(radius),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.borderColor,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(radius),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.red,
              ),
              borderRadius: BorderRadius.circular(radius),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.borderColor,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(radius),
            ),
            prefixIcon: widget.prefixWidget,
            suffixIcon: widget.suffixWidget ??
                (widget.suffixIcon != null || widget.suffixIconData != null
                    ? IconButton(
                        icon: widget.suffixIconData ??
                            SvgPicture.asset(
                              widget.suffixIcon!,
                              // color: suffixIconColor,
                              width: 24.0,
                              height: 24.0,
                            ),
                        onPressed: widget.onSuffixPressed,
                      )
                    : null),
            hintText: widget.hint,
            prefixStyle: TextStyle(
              color: widget.hintColor,
              fontSize: 13.0,
              fontWeight: FontWeight.w400,
            ),
            hintStyle: AppConstants.customNormal(
              color: widget.giveColorOpacity
                  ? widget.hintColor.withOpacity(0.8)
                  : widget.hintColor,
              size: 13.0,
              weight: widget.hintWeight ?? FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
