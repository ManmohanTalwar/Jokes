import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:jokes/main.dart';
import 'package:jokes/store/app_store.dart';
import 'package:provider/provider.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({Key? key}) : super(key: key);

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController shakeController;

  late AppStore store;

  @override
  void initState() {
    super.initState();
    shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
  }

  @override
  void dispose() {
    shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    store = context.watch<AppStore>();
    return AnimatedPositioned(
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
            timeFormatterFunction: (defaultFormatterFunction, duration) {
              if (duration.inSeconds == 0) {
                return "Start";
              } else {
                shakeController
                  ..reset()
                  ..forward(from: 0);
                return Function.apply(defaultFormatterFunction, [duration]);
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
    );
  }
}
