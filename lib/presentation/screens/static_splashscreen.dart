import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class StaticSplashScreen extends StatefulWidget {
  final String? imagePath;
  final String? onNextScreen;
  final int? duration;
  final bool? isSvg;
  final bool? isLottie;
  const StaticSplashScreen({
    Key? key,
    this.imagePath = '',
    this.onNextScreen,
    this.duration = 2500,
    this.isSvg = false,
    this.isLottie = false,
  }) : super(key: key);

  @override
  State<StaticSplashScreen> createState() => _StaticSplashScreenState();
}

class _StaticSplashScreenState extends State<StaticSplashScreen>
    with AfterLayoutMixin {
  @override
  void afterFirstLayout(BuildContext context) {
    Future.delayed(Duration(milliseconds: widget.duration!), () {
      Navigator.of(context).pushReplacementNamed(widget.onNextScreen!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 200.0,
              ),
              widget.imagePath!.startsWith('http')
                  ? Image.network(
                      widget.imagePath!,
                      fit: BoxFit.contain,
                    )
                  : widget.isSvg!
                      ? Center(
                          child: SvgPicture.asset(
                            widget.imagePath!,
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width * 0.1,
                          ),
                        )
                      : widget.isLottie!
                          ? Lottie.asset('assets/lottie/onboarding.json')
                          : Center(
                              child: Image.asset(
                                widget.imagePath!,
                                gaplessPlayback: true,
                                fit: BoxFit.contain,
                              ),
                            ),
            ],
          ),
        ),
      ),
    );
  }
}
