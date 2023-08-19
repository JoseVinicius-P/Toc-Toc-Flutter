import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:toctoc/app/modules/call/call_store.dart';
import 'package:flutter/material.dart';
import 'package:toctoc/app/shared/my_colors.dart';
import 'package:toctoc/app/shared/services/notification_service.dart';

class CallPage extends StatefulWidget {
  final String title;
  final String? data;
  const CallPage({Key? key, this.title = 'CallPage', this.data}) : super(key: key);
  @override
  CallPageState createState() => CallPageState();
}
class CallPageState extends State<CallPage> {
  final CallStore store = Modular.get();
  Map? data;

  @override
  void initState() {
    super.initState();
    store.loadMessageData(widget.data);
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
                );
              }
            ),
          ],
        )
    );
  }
}