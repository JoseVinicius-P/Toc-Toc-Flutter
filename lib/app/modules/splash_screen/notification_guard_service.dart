import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:toctoc/app/shared/services/notification_service.dart';

class NotificationGuardService extends RouteGuard{

  NotificationGuardService() : super(redirectTo: '/call');

  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) async {
    bool isCall = await NotificationService.didNotificationLaunchApp();
    return !isCall;
  }


}