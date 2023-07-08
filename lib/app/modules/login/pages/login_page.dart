import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:toctoc/app/modules/login/login_controller.dart';
import 'package:toctoc/app/modules/login/login_store.dart';
import 'package:flutter/material.dart';
import 'package:toctoc/app/shared/widgets/google_button_widget.dart';
import 'package:toctoc/app/shared/widgets/text_field_user_widget.dart';
import 'package:toctoc/app/shared/my_colors.dart';
import 'package:toctoc/app/shared/widgets/button_blue_rounded_widget.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key? key, this.title = 'LoginPage'}) : super(key: key);
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final LoginStore store = Modular.get();
  final LoginController controller = Modular.get();

  @override
  Widget build(BuildContext context) {

    Widget getScaffold(bool isPortrait, BuildContext context){
      var theme = Theme.of(context);
      return Scaffold(
        resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
                onPressed: (){
                  Modular.to.pop();
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black, size: 25,)
            ),
            forceMaterialTransparency: true,
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
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: AutoSizeText(
                          'Bem-vindo ao Toc toc',
                          style: theme.textTheme.titleMedium!.copyWith(fontSize: 8.sw.roundToDouble(), color: Colors.black54),
                          maxFontSize: 8.sw.roundToDouble(),
                          minFontSize: 4.sw.roundToDouble(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Center(
                        child: AutoSizeText(
                          'Entre em um mundo de conexões virtuais! Abra a porta para tocar a campainha dos seus amigos e criar momentos especiais.',
                          style: theme.textTheme.titleSmall!.copyWith(fontSize: 15),
                          maxFontSize: 6.sw.roundToDouble(),
                          minFontSize: 3.sw.roundToDouble(),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 55,),
                      TripleBuilder(
                        store: store,
                        builder: (context, triple) => TextFieldUserWidget(hint: 'Telefone', maskFormatter: controller.phoneMaskFormatter, enable: !triple.isLoading,)
                      ),
                      const SizedBox(height: 55,),
                      TripleBuilder(
                        store: store,//the store to be observed
                        builder: (context, triple) => ButtonBlueRoundedWidget(title: triple.isLoading ? 'Enviando' : 'Enviar código', onPressed: triple.isLoading ? null : () => store.verifyPhoneNumber(controller.phoneMaskFormatter.getUnmaskedText())),//called when any segment changes
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 35.0, horizontal: 35.0),
                        child: Divider(
                          color: MyColors.lightGray,  // Cor do divisor
                          height: 1,  // Altura do divisor
                          thickness: 1,  // Espessura do divisor
                        ),
                      ),
                      Center(
                        child:
                        TripleBuilder(
                          store: store,//the store to be observed
                          builder: (context, triple) => GoogleButtonWidget(onTap: triple.isLoading ? null : () => store.signInWithGoogle(),),//called when any segment changes
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

    return OrientationLayoutBuilder(
      portrait: (context) => getScaffold(true, context),
      landscape: (context) => getScaffold(false, context),
    );
  }
}