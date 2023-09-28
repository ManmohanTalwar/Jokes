import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:jokes/helper/app_constants.dart';
import 'package:jokes/main.dart';
import 'package:jokes/presentation/widgets/joke_card.dart';
import 'package:jokes/presentation/widgets/timer_widget.dart';
import 'package:jokes/store/app_store.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage>, WidgetsBindingObserver {
  late AppStore store;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
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
                    const TimerWidget(),
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
                              itemBuilder: (context, index) => JokeCard(
                                joke: store.jokes[index],
                              ),
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
