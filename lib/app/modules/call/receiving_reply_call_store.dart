import 'package:flutter_triple/flutter_triple.dart';
import 'package:toctoc/app/modules/call/call_service.dart';

class ReceivingReplyCallStore extends Store<String> {
  final CallService service;

  ReceivingReplyCallStore(this.service) : super("");

  void messageListener(String friendUid){
    service.messageListener(friendUid, (reply) => update(reply));
  }

}