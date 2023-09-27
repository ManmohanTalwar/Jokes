import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jokes/helper/app_constants.dart';
import 'package:jokes/store/app_store.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage>, WidgetsBindingObserver {
  Timer? _timerLink;

  late AppStore store;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timerLink?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    store = context.watch<AppStore>();
    return WillPopScope(
      onWillPop: () => onWillPop(context),
      child: const SafeArea(
        child: Scaffold(
          backgroundColor: AppConstants.white,
          body: Column(),
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
