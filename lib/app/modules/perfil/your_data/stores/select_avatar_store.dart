import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:toctoc/app/modules/perfil/your_data/services/image_picker_service.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:toctoc/app/shared/my_colors.dart';

class SelectAvatarStore extends Store<String> {

  final ImagePickerService imagePickerService;

  SelectAvatarStore(this.imagePickerService) : super("");

  void pickImage() async{
    String path = await imagePickerService.pickImage();
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      cropStyle: CropStyle.circle,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 90,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      uiSettings: [
        AndroidUiSettings(
          backgroundColor: Colors.white,
          toolbarTitle: 'Cortar',
          toolbarColor: Colors.white,
          toolbarWidgetColor: Colors.black,
          activeControlsWidgetColor: MyColors.textColor,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
          dimmedLayerColor: Colors.black.withOpacity(0.1),
          statusBarColor: Colors.blue,
          cropFrameColor: Colors.white,
        ),
      ],
    );

    update(croppedFile?.path ?? "");
  }

}