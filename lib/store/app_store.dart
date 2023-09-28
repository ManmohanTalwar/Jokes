import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:jokes/helper/app_prefs.dart';
import 'package:jokes/helper/flash_helper.dart';
import 'package:jokes/main.dart';
import 'package:jokes/models/joke.dart';
import 'package:jokes/services/services.dart';
import 'package:mobx/mobx.dart';

part 'app_store.g.dart';

class AppStore = _AppStore with _$AppStore;

abstract class _AppStore with Store {
  @observable
  bool isLoading = false;

  @observable
  ObservableList<String> jokes = ObservableList<String>();

  ScrollController scrollController = ScrollController();

  CountDownController countController = CountDownController();

  @action
  Future<void> init() async {
    getJoke();
    countController.restart(duration: 60);
  }

  @action
  Future<void> getJoke() async {
    final jsonData = locator<AppPrefs>().jokes.getValue();
    if (jokes.isEmpty) {
      jokes.addAll(jsonData.values.toList().map((e) => e.toString()).toList());
    }
    final response = await Services().getJoke();
    countController.restart(duration: 60);
    if (response.statusCode < 400) {
      final jsonResp = json.decode(response.body);
      Joke joke = Joke.fromJson(jsonResp);
      if (jokes.isNotEmpty && jokes.length < 10) {
        jokes.add(joke.joke ?? '');
        jsonData.addAll({'${jsonData.length + 1}': joke.joke});
        locator<AppPrefs>().jokes.setValue(jsonData);
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          scrollController.animateTo(
            10 * 120,
            duration: const Duration(milliseconds: 1000),
            curve: Curves.fastOutSlowIn,
          );
        });
      } else {
        if (jokes.isNotEmpty) {
          jokes.removeLast();
          jsonData.remove('${jsonData.length}');
        }
        jsonData.addAll({'${jsonData.length + 1}': joke.joke});
        jokes.add(joke.joke ?? '');
        locator<AppPrefs>().jokes.setValue(jsonData);
        if (jokes.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            scrollController.animateTo(
              10 * 120,
              duration: const Duration(milliseconds: 1000),
              curve: Curves.fastOutSlowIn,
            );
          });
        }
      }
    } else {
      FlashHelper.errorBar(message: 'Please try again...');
    }
  }
}
