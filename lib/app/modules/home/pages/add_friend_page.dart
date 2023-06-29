import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:toctoc/app/shared/my_colors.dart';

class AddFriendPage extends StatefulWidget {
  final String title;
  const AddFriendPage({Key? key, this.title = 'AddFriendPage'}) : super(key: key);
  @override
  AddFriendPageState createState() => AddFriendPageState();
}
class AddFriendPageState extends State<AddFriendPage> {
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
              padding: const EdgeInsets.all(20.0),
              child: SafeArea(
                child: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AutoSizeText(
                                'Escaneie para me adicionar a sua lista de amigos!',
                                style: theme.textTheme.titleSmall!.copyWith(fontSize: 18),
                                maxFontSize: 6.sw.roundToDouble(),
                                minFontSize: 3.sw.roundToDouble(),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 5,),
                              AutoSizeText(
                                '*Para adicionar seu amigo escaneie o QR Code dele!',
                                style: theme.textTheme.titleSmall!.copyWith(fontSize: 13, color: Colors.red),
                                maxFontSize: 6.sw.roundToDouble(),
                                minFontSize: 3.sw.roundToDouble(),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 60,),
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15),
                              ),
                              border: Border.all(
                                width: 1,
                                style: BorderStyle.solid,
                                color: Colors.grey,
                              ),
                            ),
                            child: const ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                              child: Image(
                                width: double.infinity,
                                image: AssetImage('assets/images/qr_code.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyColors.blue, // Altera a cor de fundo
                              shape: const CircleBorder(),
                            ),
                            onPressed: (){},
                            child: const Padding(
                              padding: EdgeInsets.all(13.0),
                              child: Icon(Icons.qr_code_scanner_rounded, color: Colors.white,),
                            ),
                          ),
                          Text(
                            "Escanear",
                            style: theme.textTheme.labelSmall!.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
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