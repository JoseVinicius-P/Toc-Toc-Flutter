import 'dart:async';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:toctoc/app/modules/call/call_store.dart';
import 'package:flutter/material.dart';
import 'package:toctoc/app/modules/call/receiving_reply_call_store.dart';
import 'package:toctoc/app/shared/my_colors.dart';
import 'package:toctoc/app/shared/services/notification_service.dart';

class CallPage extends StatefulWidget {
  final String title;
  final String? data;
  final bool isReceivingCall;
  final bool isAppInBackground;
  const CallPage({Key? key, this.title = 'CallPage', this.data, required this.isReceivingCall, required this.isAppInBackground}) : super(key: key);
  @override
  CallPageState createState() => CallPageState();
}
class CallPageState extends State<CallPage> {
  final callStore = Modular.get<CallStore>();
  final receivingReplyCallStore = Modular.get<ReceivingReplyCallStore>();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    callStore.loadData(widget.data);
    if(!widget.isReceivingCall){
      Map<String, dynamic> data = jsonDecode(widget.data!);
      callStore.callFriend(data['friendUid']);
      receivingReplyCallStore.messageListener(data['friendUid']);
      startTimer(30);
    }else{
      NotificationService.stopNotificationDurationSecondsCount();
      startTimer(30-NotificationService.notificationDurationSeconds);
      NotificationService.notificationDurationSeconds = 0;
    }
  }

  void startTimer(int seconds){
    timer = Timer(Duration(seconds: seconds), () async {
      closeCallModule();
    });
  }

  void stopTimer(){
    if(timer != null){
      timer!.cancel();
    }
  }

  void closeCallModule() async {
    await NotificationService.notification.cancelAll();
    if(widget.isReceivingCall && widget.isAppInBackground){
      SystemNavigator.pop();
    }else{
      Modular.to.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              color: Colors.white,
            ),
            TripleBuilder(
              store: callStore,
              builder: (context, triple) {
                var data = triple.state as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
                  child: SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 15,),
                        AutoSizeText(
                          widget.isReceivingCall ? 'Você está recebendo uma visita!' : 'Você está fazendo uma visita!',
                          style: theme.textTheme.labelMedium!.copyWith(fontSize: 18, color: MyColors.textColor.withOpacity(0.1)),
                          maxFontSize: 6.sw.roundToDouble(),
                          minFontSize: 3.sw.roundToDouble(),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30,),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 40.sw.roundToDouble(),
                              height: 40.sw.roundToDouble(),
                              child:  CircleAvatar(
                                backgroundImage: const AssetImage('assets/images/perfil.png'),
                                foregroundImage: CachedNetworkImageProvider(
                                    data['profilePictureUrl']
                                ),
                                radius: 40.sw.roundToDouble(),
                              ),
                            )

                          ],
                        ),
                        const SizedBox(height: 10,),
                        AutoSizeText(
                          data['name'],
                          style: theme.textTheme.titleSmall!.copyWith(fontSize: 25),
                          maxFontSize: 6.sw.roundToDouble(),
                          minFontSize: 3.sw.roundToDouble(),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10,),
                        TripleBuilder(
                            store: receivingReplyCallStore,
                            builder: (builder, triple){
                              String reply = triple.state as String;
                              if(reply != ''){
                                return Stack(
                                  children: [
                                    Center(
                                      child: Transform.rotate(
                                        angle: 0.8,
                                        child: Container(
                                          width: 15,
                                          height: 15,
                                          decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(2)),
                                              color: MyColors.lightGray
                                          ),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 7.5,),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.all(
                                                Radius.circular(15),
                                              ),
                                              color: MyColors.lightGray
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(12.0),
                                              child: AutoSizeText(
                                                reply,
                                                style: theme.textTheme.labelMedium!.copyWith(fontSize: 18, color: Colors.black),
                                                maxFontSize: 6.sw.roundToDouble(),
                                                minFontSize: 3.sw.roundToDouble(),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }else{
                                return const SizedBox();
                              }
                            }),
                      ],
                    ) ,
                  ),
                );
              }
            ),
            Visibility(
              visible: !widget.isReceivingCall,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColors.blue, // Altera a cor de fundo
                            shape: const CircleBorder(),
                            disabledBackgroundColor: MyColors.blue,
                          ),
                          onPressed: () {
                            stopTimer();
                            closeCallModule();
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(18.0),
                            child: Icon(Icons.close_rounded, color: Colors.white, size: 30,),
                          ),
                        ),
                        SizedBox(height: 15,),
                        AutoSizeText(
                          'Fechar',
                          style: theme.textTheme.titleSmall!.copyWith(fontSize: 18),
                          maxFontSize: 6.sw.roundToDouble(),
                          minFontSize: 3.sw.roundToDouble(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 15,),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: widget.isReceivingCall,
              child: TripleBuilder(
                store: callStore,
                builder: (context, triple) {
                  var data = triple.state as Map<String, dynamic>;
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: MyColors.errorRed, // Altera a cor de fundo
                                shape: const CircleBorder(),
                                disabledBackgroundColor: MyColors.errorRed,
                              ),
                              onPressed: () async{
                                stopTimer();
                                await callStore.sendReply("Não estou em casa!", data['callId']);
                                closeCallModule();
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(13.0),
                                child: Icon(Icons.close, color: Colors.white,),
                              ),
                            ),
                            AutoSizeText(
                              'Não estou\nem casa',
                              style: theme.textTheme.titleSmall!.copyWith(fontSize: 15),
                              maxFontSize: 6.sw.roundToDouble(),
                              minFontSize: 3.sw.roundToDouble(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: MyColors.blue, // Altera a cor de fundo
                                shape: const CircleBorder(),
                                disabledBackgroundColor: MyColors.blue,
                              ),
                              onPressed: () async {
                                stopTimer();
                                await callStore.sendReply("Estou indo!", data['callId']);
                                closeCallModule();
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(18.0),
                                child: Icon(Icons.meeting_room_outlined, color: Colors.white, size: 30,),
                              ),
                            ),
                            AutoSizeText(
                              'Estou indo!\n ',
                              style: theme.textTheme.titleSmall!.copyWith(fontSize: 18),
                              maxFontSize: 6.sw.roundToDouble(),
                              minFontSize: 3.sw.roundToDouble(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 15,),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: MyColors.lightGray, // Altera a cor de fundo
                                shape: const CircleBorder(),
                                disabledBackgroundColor: MyColors.lightGray,
                              ),
                              onPressed: () => closeCallModule(),
                              child: const Padding(
                                padding: EdgeInsets.all(13.0),
                                child: Icon(Icons.door_back_door_outlined, color: MyColors.textColor,),
                              ),
                            ),
                            AutoSizeText(
                              'Ignorar\n ',
                              style: theme.textTheme.titleSmall!.copyWith(fontSize: 15),
                              maxFontSize: 6.sw.roundToDouble(),
                              minFontSize: 3.sw.roundToDouble(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
              ),
            )
          ],
        )
    );
  }
}