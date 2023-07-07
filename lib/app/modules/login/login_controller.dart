import 'package:flutter_modular/flutter_modular.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class LoginController implements Disposable{

  final maskFormatter = MaskTextInputFormatter(
      mask: '(##) # ####-####',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );

  LoginController();

  @override
  void dispose() {

  }

  void toCompleteRegistrationModule(){
    Modular.to.navigate('/complete_registration/');
  }

  void toSmsCodePage(String verificationId){
    Modular.to.pushNamed("./sms_code", arguments: {
      'verificationId': verificationId,
    });
  }


}