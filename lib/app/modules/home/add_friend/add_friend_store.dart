import 'package:flutter_triple/flutter_triple.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:toctoc/app/modules/home/home_controller.dart';

class AddFriendStore extends Store<String> {
  final HomeController homeController;

  AddFriendStore(this.homeController) : super('');

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
        }
      });
    }catch(e){
      print("ERRO: $e");
    }
  }

}