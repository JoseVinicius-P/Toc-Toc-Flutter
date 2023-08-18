import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:toctoc/app/modules/call/call_store.dart';
import 'package:flutter/material.dart';
import 'package:toctoc/app/shared/my_colors.dart';

class CallPage extends StatefulWidget {
  final String title;
  final String data;
  const CallPage({Key? key, this.title = 'CallPage', required this.data}) : super(key: key);
  @override
  CallPageState createState() => CallPageState();
}
class CallPageState extends State<CallPage> {
  final CallStore store = Modular.get();
  late final data;

  @override
  void initState() {
    super.initState();
    data = jsonDecode(widget.data);
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
            Padding(
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
                                foregroundImage: NetworkImage(
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
                          'Você está sendo visitado!',
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
            ),
          ],
        )
    );
  }
}