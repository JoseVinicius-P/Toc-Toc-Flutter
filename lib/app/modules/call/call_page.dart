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
import 'package:toctoc/app/shared/my_colors.dart';

class CallPage extends StatefulWidget {
  final String title;
  final String? data;
  final bool receivingCall;
  const CallPage({Key? key, this.title = 'CallPage', this.data, required this.receivingCall}) : super(key: key);
  @override
  CallPageState createState() => CallPageState();
}
class CallPageState extends State<CallPage> {
  final CallStore store = Modular.get();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    store.loadData(widget.data);
    if(!widget.receivingCall){
      Map<String, dynamic> data = jsonDecode(widget.data!);
      store.callFriend(data['friendUid']);
    }
    startTimer();
  }

  void startTimer(){
    timer = Timer(const Duration(seconds: 30), () {
      if(widget.receivingCall == true){
        SystemNavigator.pop();
      }else{
        Modular.to.pop();
      }
    });
  }

  void stopTimer(){
    if(timer != null){
      timer!.cancel();
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
              store: store,
              builder: (context, triple) {
                var data = triple.state as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
                  child: SafeArea(
                    child: Stack(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 35,),
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
                                ),
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
                            const SizedBox(height: 5,),
                            AutoSizeText(
                              'Você está recebendo uma visita!',
                              style: theme.textTheme.labelMedium!.copyWith(fontSize: 18, color: MyColors.textColor.withOpacity(0.3)),
                              maxFontSize: 6.sw.roundToDouble(),
                              minFontSize: 3.sw.roundToDouble(),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ) ,
                  ),
                );
              }
            ),
            TripleBuilder(
              store: store,
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
                            onPressed: () {
                              stopTimer();
                              store.sendReply("Não está em casa!", data['callId']);
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
                            onPressed: () {
                              stopTimer();
                              store.sendReply("Está vindo atender!", data['callId']);
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
                          SizedBox(height: 15,),
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
                            onPressed: (){},
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
            )
          ],
        )
    );
  }
}