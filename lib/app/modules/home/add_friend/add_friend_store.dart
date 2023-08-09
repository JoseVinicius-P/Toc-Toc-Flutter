import 'package:flutter/cupertino.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:toctoc/app/modules/home/home_controller.dart';
import 'package:toctoc/app/modules/home/services/friend_service.dart';

class AddFriendStore extends Store<String> {
  final HomeController homeController;
  final FriendService friendService;

  AddFriendStore(this.homeController, this.friendService) : super('');

  void enableQrCodeScan(bool enable){
    setLoading(enable);
  }

  void onQRViewCreated(QRViewController controller) {
    try{
      homeController.qrViewController = controller;
      homeController.qrViewController!.scannedDataStream.listen((scanData) {
        if(scanData.code != null){
          update(scanData.code!);
          enableQrCodeScan(false);
          addFriend();
        }
      });
    }catch(e){
      print("ERRO: $e");
    }
  }

  void addFriend() async {
    if(await friendService.addFriend(state)){
      homeController.pageViewController.animateToPage(0, // Índice da página para animar
        duration: const Duration(milliseconds: 800), // Duração da animação
        curve: Curves.easeInOutCubicEmphasized, // Curva de animação
      );
    }
  }

}