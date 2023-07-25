import 'package:flutter_triple/flutter_triple.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:toctoc/app/modules/home/home_controller.dart';
import 'package:toctoc/app/modules/home/add_friend/friend_service.dart';

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
      print("Adicionado");
    }
  }

}