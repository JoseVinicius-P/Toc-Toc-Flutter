import 'package:flutter_triple/flutter_triple.dart';
import 'package:toctoc/app/modules/perfil/services/image_picker_service.dart';

class SelectAvatarStore extends Store<String> {

  final ImagePickerService imagePickerService;

  SelectAvatarStore(this.imagePickerService) : super("");

  void pickImage() async{
    update(await imagePickerService.pickImage());
  }

}