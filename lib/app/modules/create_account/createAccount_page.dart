import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:toctoc/app/modules/create_account/createAccount_store.dart';
import 'package:flutter/material.dart';
import 'package:toctoc/app/shared/widgets/google_button_widget.dart';
import 'package:toctoc/app/shared/widgets/text_field_password_widget.dart';
import 'package:toctoc/app/shared/widgets/text_field_user_widget.dart';
import 'package:toctoc/app/shared/my_colors.dart';
import 'package:toctoc/app/shared/widgets/button_blue_rounded_widget.dart';

class CreateAccountPage extends StatefulWidget {
  final String title;
  const CreateAccountPage({Key? key, this.title = 'CreateAccountPage'}) : super(key: key);
  @override
  CreateAccountPageState createState() => CreateAccountPageState();
}
class CreateAccountPageState extends State<CreateAccountPage> {
  final CreateAccountStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
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
                        'Entre em um mundo de conexões virtuais! Junte-se a nós para tocar a campainha dos seus amigos e criar momentos especiais.',
                        style: theme.textTheme.titleSmall!.copyWith(fontSize: 15),
                        maxFontSize: 6.sw.roundToDouble(),
                        minFontSize: 3.sw.roundToDouble(),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 55,),
                    TextFieldUserWidget(hint: 'Telefone',),
                    const SizedBox(height: 30,),
                    TextFieldPasswordWidget(hint: 'Crie sua senha',),
                    const SizedBox(height: 10,),
                    TextFieldPasswordWidget(hint: 'Confirme sua senha',),
                    const SizedBox(height: 25,),
                    TripleBuilder(
                      store: store,//the store to be observed
                      builder: (context, triple) => ButtonBlueRoundedWidget(title: 'Criar minha conta', onPressed: triple.isLoading ? null : (){}),//called when any segment changes
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
                        builder: (context, triple) => GoogleButtonWidget(onTap: triple.isLoading ? null : (){},),//called when any segment changes
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