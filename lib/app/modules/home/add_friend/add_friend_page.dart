import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:toctoc/app/modules/home/home_controller.dart';
import 'package:toctoc/app/shared/my_colors.dart';

class AddFriendPage extends StatefulWidget {
  final String title;
  const AddFriendPage({Key? key, this.title = 'AddFriendPage'}) : super(key: key);
  @override
  AddFriendPageState createState() => AddFriendPageState();
}
class AddFriendPageState extends State<AddFriendPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final homeController = Modular.get<HomeController>();

  @override
  void reassemble() {
    super.reassemble();
    homeController.qrViewController!.pauseCamera();
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
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15),
                              ),
                              child: Builder(
                                  builder: (context) {
                                    if(false){
                                      return QrImageView(
                                        data: FirebaseAuth.instance.currentUser!.uid,
                                        version: 6,
                                        padding: const EdgeInsets.all(40.0),
                                      );
                                    }else{
                                      return AspectRatio(
                                        aspectRatio: 1/1,
                                        child: QRView(
                                            key: qrKey,
                                            onQRViewCreated: _onQRViewCreated
                                        ),
                                      );
                                    }
                                  }
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

  void _onQRViewCreated(QRViewController controller) {
    homeController.qrViewController = controller;
    controller.scannedDataStream.listen((scanData) {
      print("ESCANEOU: ${scanData.code}");
    });
  }

}