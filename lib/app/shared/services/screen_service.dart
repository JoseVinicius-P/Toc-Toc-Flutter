

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:screen_state/screen_state.dart';

class ScreenService {
  static void onData(ScreenStateEvent event) {
    if(event == ScreenStateEvent.SCREEN_OFF){
      SystemNavigator.pop();
    }
  }

  static void initScreenLockListener() {
    Screen screen;
    StreamSubscription<ScreenStateEvent> _subscription;
    screen = Screen();
    try {
      _subscription = screen.screenStateStream!.listen(onData);
    } on ScreenStateException catch (exception) {
      debugPrint("ERRO AO INICIAR SCREEN LISTENNER: $exception");
    }
  }
}