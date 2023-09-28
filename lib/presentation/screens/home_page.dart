import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:jokes/helper/app_constants.dart';
import 'package:jokes/main.dart';
import 'package:jokes/store/app_store.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with
        AutomaticKeepAliveClientMixin<HomePage>,
        WidgetsBindingObserver,
        SingleTickerProviderStateMixin {
  late AnimationController shakeController;

  late AppStore store;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    store = context.watch<AppStore>();
    return WillPopScope(
      onWillPop: () => onWillPop(context),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppConstants.white,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                Stack(
                  children: [
                    Center(
                      child: Lottie.asset(
                        'assets/lottie/laugh_1.json',
                        width: context.getWidth() * 0.4,
                      ),
                    ),
                    AnimatedPositioned(
                      right: 0.0,
                      top: 0.0,
                      duration: const Duration(milliseconds: 450),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularCountDownTimer(
                            duration: 60,
                            initialDuration: 0,
                            controller: store.countController,
                            width: 60.0,
                            height: 60.0,
                            ringColor: Colors.grey[300]!,
                            ringGradient: null,
                            fillColor: Colors.purpleAccent[100]!,
                            fillGradient: null,
                            backgroundColor: Colors.purple[500],
                            backgroundGradient: null,
                            strokeWidth: 10.0,
                            strokeCap: StrokeCap.round,
                            textStyle: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textFormat: CountdownTextFormat.S,
                            isReverse: true,
                            isReverseAnimation: true,
                            isTimerTextShown: true,
                            autoStart: true,
                            onStart: () {
                              debugPrint('Countdown Started');
                            },
                            onComplete: () {
                              debugPrint('Countdown Ended');
                              shakeController
                                ..reset()
                                ..forward(from: 0);
                            },
                            onChange: (String timeStamp) {
                              debugPrint('Countdown Changed $timeStamp');
                              shakeController
                                ..reset()
                                ..forward(from: 0);
                            },
                            timeFormatterFunction:
                                (defaultFormatterFunction, duration) {
                              if (duration.inSeconds == 0) {
                                return "Start";
                              } else {
                                shakeController
                                  ..reset()
                                  ..forward(from: 0);
                                return Function.apply(
                                    defaultFormatterFunction, [duration]);
                              }
                            },
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          SizedBox(
                            child: Text(
                              'Next Joke\nComing Up in',
                              textAlign: TextAlign.center,
                              style: context.customStyle(
                                size: 14.0,
                                color: context.black(),
                              ),
                            ).animate(controller: shakeController)
                              ..shake(duration: 300.ms),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50.0,
                ),
                Expanded(
                  child: Observer(
                      builder: (context) => store.jokes.isNotEmpty
                          ? ListView.builder(
                              itemCount: store.jokes.length,
                              shrinkWrap: true,
                              controller: store.scrollController,
                              itemBuilder: (context, index) =>
                                  AnimatedContainer(
                                duration: const Duration(milliseconds: 450),
                                padding: const EdgeInsets.all(16.0),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 2.0,
                                  vertical: 16.0,
                                ),
                                decoration: BoxDecoration(
                                  color: context.white(),
                                  borderRadius: BorderRadius.circular(12.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[200]!,
                                      blurRadius: 20.0,
                                      // offset: const Offset(0, 1),
                                      spreadRadius: 5.0,
                                    )
                                  ],
                                ),
                                child: Text(
                                  store.jokes[index],
                                  style: context.customStyle(
                                    size: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                                      .animate()
                                      .fadeIn(
                                        duration: 350.ms,
                                      )
                                      .slideX(duration: 450.ms),
                            )
                          : const CircularProgressIndicator()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

Future<bool> onWillPop(BuildContext context) async {
  return await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
// title:  Text('Are you sure?'),
          content: const Text("EXIT APP"),
          actions: <Widget>[
            OutlinedButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("NO"),
            ),
            OutlinedButton(
              onPressed: () {
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
              child: const Text("YES"),
            ),
          ],
        ),
      ) ??
      false;
}
