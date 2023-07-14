import 'package:flutter_modular/flutter_modular.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class LoginController implements Disposable{

  final phoneMaskFormatter = MaskTextInputFormatter(
      mask: '(##) # ####-####',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );

  final smsCodeMaskFormatter = MaskTextInputFormatter(
      mask: '# # # # # #',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );

  LoginController();

  @override
  void dispose() {

  }

  void toPerfilModule(){
    Modular.to.navigate('/perfil/');
  }

  void toSmsCodePage(String verificationId){
    Modular.to.pushNamed("./sms_code", arguments: {
      'verificationId': verificationId,
    });
  }


}