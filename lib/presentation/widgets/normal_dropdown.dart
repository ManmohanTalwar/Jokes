import 'package:jokes/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jokes/presentation/widgets/prefix_icon_widget.dart';

class NormalDropDown extends StatelessWidget {
  final String text;
  final String? label;
  final bool isFromListing;
  final bool isCenter;
  final GestureTapCallback onTap;
  final bool showIcon;

  const NormalDropDown({
    Key? key,
    required this.text,
    this.label,
    this.isFromListing = false,
    this.isCenter = false,
    this.showIcon = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: isFromListing
          ? AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                // borderRadius: BorderRadius.circular(12.0),
                borderRadius: BorderRadius.circular(18.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueGrey.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 20.0,
                    offset: const Offset(-4, 0),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: isCenter ? MainAxisSize.min : MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const PrefixIconWidget(
                        isImage: true,
                      ),
                      const SizedBox(
                        width: 4.0,
                      ),
                      Container(
                        width: 1.5,
                        height: 24.0,
                        decoration: BoxDecoration(
                          color: context.greyTextColor().withOpacity(0.5),
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      Text(
                        text,
                        style: context.customStyle(
                          fontWeight: FontWeight.bold,
                          color: context.black(),
                          size: 15.0,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: context.darkTextColor(),
                    size: 20.0,
                  ),
                ],
              ),
            )
          : AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                // borderRadius: BorderRadius.circular(12.0),
                borderRadius: BorderRadius.circular(18.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueGrey.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 20.0,
                    offset: const Offset(-4, 0),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (label != null) ...{
                    Text(
                      label!,
                      style: context.customStyle(
                        size: 14.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black.withOpacity(0.4),
                      ),
                    ),
                    const SizedBox(
                      height: 6.0,
                    ),
                  },
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (showIcon) ...{
                        SvgPicture.asset('assets/svg/search.svg'),
                        const SizedBox(
                          width: 8.0,
                        ),
                      },
                      Flexible(
                        child: Text(
                          text,
                          overflow: TextOverflow.ellipsis,
                          style: context.customStyle(
                            size: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/svg/arrow_down.svg',
                        height: 6.0,
                        width: 6.0,
                        color: context.black().withOpacity(0.4),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}

class DropDownWithLabel extends StatelessWidget {
  final String text;
  final String? label;
  final GestureTapCallback onTap;
  final GestureTapCallback? onClearTapped;
  final bool showClear;
  final bool showIcon;

  const DropDownWithLabel({
    Key? key,
    required this.text,
    this.label,
    this.showIcon = false,
    this.showClear = false,
    required this.onTap,
    this.onClearTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...{
          Text(
            label!,
            style: context.customStyle(
              size: 14.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 6.0,
          ),
        },
        InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black.withOpacity(0.4),
              ),
              color: context.white(),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (showIcon) ...{
                        SvgPicture.asset(
                          'assets/svg/search.svg',
                          color: Colors.black.withOpacity(0.4),
                          width: 16.0,
                          height: 16.0,
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                      },
                      Flexible(
                        child: Text(
                          text,
                          overflow: TextOverflow.ellipsis,
                          style: context.customStyle(
                            size: 14.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (showClear)
                  InkWell(
                    onTap: onClearTapped,
                    child: const Icon(
                      Icons.close,
                      size: 18.0,
                      color: Colors.black,
                    ),
                  )
                else
                  SvgPicture.asset(
                    'assets/svg/arrow_down.svg',
                    height: 6.0,
                    width: 6.0,
                    color: Colors.black,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
