import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:toctoc/app/modules/login/login_controller.dart';
import 'package:toctoc/app/modules/login/login_store.dart';
import 'package:toctoc/app/shared/my_colors.dart';
import 'package:toctoc/app/shared/widgets/button_blue_rounded_widget.dart';

class SmsCodePage extends StatefulWidget {
  final String title;
  final String verificationId;
  const SmsCodePage({Key? key, this.title = 'SmsCodePage', required this.verificationId}) : super(key: key);
  @override
  SmsCodePageState createState() => SmsCodePageState();
}
class SmsCodePageState extends State<SmsCodePage> {
  final store = Modular.get<LoginStore>();
  final controller = Modular.get<LoginController>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
              onPressed: (){
                Modular.to.pop();
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black, size: 25,)
          ),
          forceMaterialTransparency: true,
          title: Text(
            "Código de verificação",
            style: theme.textTheme.titleSmall!.copyWith(color: MyColors.blue),
          ),
        ),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: SafeArea(
                child: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: AutoSizeText(
                            'Você receberá um código SMS para confirmar que o número de telefone é seu.',
                            style: theme.textTheme.titleSmall!.copyWith(fontSize: 18),
                            maxFontSize: 6.sw.roundToDouble(),
                            minFontSize: 3.sw.roundToDouble(),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 30,),
                        Container(
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
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [controller.smsCodeMaskFormatter],
                            onChanged: (text){},
                            //definindo estilo do texto
                            style: theme.textTheme.labelMedium,
                            cursorColor: MyColors.textColor,
                            //retirando autocorreção de texto
                            autocorrect: false,
                            //definindo estilo do container do textfield
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              //Definindo hint usando varivel da classe personalizada MyStrings
                              hintText: 'Código',
                              hintStyle: theme.textTheme.labelMedium,
                              prefixIcon: const Icon(Icons.sms_outlined, color: MyColors.textColor,),
                              filled: false,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TripleBuilder(
                        store: store,//the store to be observed
                        builder: (context, triple) => ButtonBlueRoundedWidget(
                            title: 'Confirmar',
                            onPressed: () => store.signInWithPhoneNumber(
                                controller.smsCodeMaskFormatter.getUnmaskedText(),
                                widget.verificationId)
                        ),
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
}