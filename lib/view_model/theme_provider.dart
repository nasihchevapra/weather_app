import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider() {
    updateThemeBasedOnTime();
    startTimerToUpdateTheme();
  }
  bool light1 = false;
  Timer? timer;
  void startTimerToUpdateTheme() {
    const duration = Duration(seconds: 1);
    timer = Timer.periodic(duration, (Timer timer) {
      updateThemeBasedOnTime();
      notifyListeners();
    });
  }

  void updateThemeBasedOnTime() {
    String mydate = DateFormat('hh:mm a').format(DateTime.now());
    String amPM = DateFormat('a').format(DateTime.now());
    DateTime parsedTime = DateFormat('hh:mm').parse(mydate);

    int hours = parsedTime.hour;
    int minutes = parsedTime.minute;

    if ((hours >= 6 && minutes >= 30 && amPM == 'PM')) {
      theme(true);
    }
    if ((hours >= 6 && minutes >= 30 && amPM == 'AM')) {
      theme(false);
    }

    notifyListeners();
  }

  void theme(bool value) {
    light1 = value;
    notifyListeners();
  }
}
