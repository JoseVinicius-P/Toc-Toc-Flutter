import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:toctoc/app/modules/perfil/services/image_picker_service.dart';
import 'package:image_cropper/image_cropper.dart';

class SelectAvatarStore extends Store<String> {

  final ImagePickerService imagePickerService;

  SelectAvatarStore(this.imagePickerService) : super("");

  void pickImage() async{
    String path = await imagePickerService.pickImage();
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.transparent,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
      ],
    );

    update(croppedFile?.path ?? "");
  }

}