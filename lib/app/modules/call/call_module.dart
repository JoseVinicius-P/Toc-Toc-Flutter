import 'package:toctoc/app/modules/call/call_service.dart';
import 'package:toctoc/app/modules/call/call_page.dart';
import 'package:toctoc/app/modules/call/call_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CallModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CallService()),
    Bind.lazySingleton((i) => CallStore(i())),
  ];


  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) {
      String? data;
      bool isReceivingCall;
      bool isAppInBackground;
      try{
        data = args.data['data'];
      }catch(e){
        data = null;
      }
      try{
        isReceivingCall = args.data['receivingCall'];
      }catch(e){
        isReceivingCall = true;
      }
      try{
        isAppInBackground = args.data['isAppInBackground'];
      }catch(e){
        isAppInBackground = true;
      }
      return CallPage(data:data, isReceivingCall: isReceivingCall, isAppInBackground: isAppInBackground);
    }),
  ];

}