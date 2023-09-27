import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jokes/main.dart';
import 'package:jokes/presentation/widgets/search_container.dart';
import 'package:jokes/routes/route_list.dart';
import 'package:jokes/services/navigation_service.dart';

class AnimatedAppBar extends StatelessWidget {
  final bool isNormal;
  final String? title;
  final Widget? bottom;
  final GestureTapCallback? onBackPressed;
  final AnimationController? controller;
  const AnimatedAppBar({
    super.key,
    this.isNormal = true,
    this.title,
    this.bottom,
    this.onBackPressed,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      color: context.primaryColor(),
      padding: const EdgeInsets.only(
        left: 12.0,
        right: 12.0,
        top: 12.0,
      ),
      child: isNormal
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: onBackPressed,
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        title ?? '',
                        style: context.customStyle(
                          color: Colors.white,
                          size: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                if (bottom != null) bottom!,
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 22.0,
                          backgroundImage:
                              AssetImage('assets/images/profile_picture.png'),
                        ),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/icons/navigation.svg',
                                  color: context.greyTextColor(),
                                  height: 14.0,
                                ),
                                const SizedBox(
                                  width: 4.0,
                                ),
                                Text(
                                  'Your Location',
                                  style: context.customStyle(
                                    color: context.greyTextColor(),
                                    size: 14.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 2.0,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Wertheimer, Illinois',
                                  style: context.customStyle(
                                    color: Colors.white,
                                    size: 14.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.notifications_none),
                    )
                  ],
                ),
                const SizedBox(
                  height: 14.0,
                ),
                InkWell(
                  onTap: () {},
                  child: Hero(
                    tag: 'Search-Container',
                    flightShuttleBuilder:
                        (c, ani, direction, fromContext, toContext) {
                      switch (direction) {
                        case HeroFlightDirection.push:
                          return ScaleTransition(
                            scale: ani.drive(
                              Tween(
                                begin: 0.5,
                                end: 1.0,
                              ).chain(
                                CurveTween(curve: Curves.fastOutSlowIn),
                              ),
                            ),
                            child: fromContext.widget,
                          );
                        case HeroFlightDirection.pop:
                          return SlideTransition(
                              position: ani.drive(Tween<Offset>(
                                begin: const Offset(0, -0.05),
                                end: const Offset(0, 0),
                              ).chain(
                                CurveTween(curve: Curves.linearToEaseOut),
                              )),
                              child: toContext.widget);
                      }
                    },
                    child: const SearchContainer(),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
              ],
            ),
    )
        .animate(controller: controller)
        .fadeIn(duration: 300.ms)
        .then()
        .slide(duration: 450.ms);
  }
}
