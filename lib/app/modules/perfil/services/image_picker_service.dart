import 'package:image_picker/image_picker.dart';

class ImagePickerService {

  Future<String> pickImage() async {
    final XFile? pickedImage;
    ImagePicker picker = ImagePicker();
    try{
      pickedImage = await picker.pickImage(source: ImageSource.gallery);
      return pickedImage!.path;
    }catch(e, stackTrace){
      print('ERRO: $e, $stackTrace');
      return " ";
    }
  }
}