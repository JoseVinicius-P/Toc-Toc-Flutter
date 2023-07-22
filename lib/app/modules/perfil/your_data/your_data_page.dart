import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:toctoc/app/modules/perfil/your_data/stores/your_data_store.dart';
import 'package:flutter/material.dart';
import 'package:toctoc/app/modules/perfil/perfil_controller.dart';
import 'package:toctoc/app/modules/perfil/your_data/select_avatar_widget.dart';
import 'package:toctoc/app/shared/my_colors.dart';
import 'package:toctoc/app/shared/widgets/button_blue_rounded_widget.dart';
import 'package:toctoc/app/shared/widgets/text_field_widget.dart';

class YourDataPage extends StatefulWidget {
  final String title;
  const YourDataPage({Key? key, this.title = 'CompleteRegistrationPage'}) : super(key: key);
  @override
  YourDataPageState createState() => YourDataPageState();
}

class YourDataPageState extends State<YourDataPage> {
  final store = Modular.get<YourDataStore>();
  final controller = Modular.get<PerfilController>();
  final bool isForHome = Modular.to.path.contains('home');

  @override
  void initState() {
    super.initState();
    store.loadUserdata();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
              onPressed: (){
                if(isForHome){
                  Navigator.of(context).pop();
                }else{
                  SystemNavigator.pop();
                }
              },
              icon: Icon(isForHome ? Icons.arrow_back_ios_new_rounded : Icons.close_rounded, color: Colors.black, size: 25,)
          ),
          forceMaterialTransparency: true,
          title: Text(
            "Seus dados",
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
                          'Estes dados são necessários para facilitar a identificação pelos seus amigos!',
                          style: theme.textTheme.titleSmall!.copyWith(fontSize: 18),
                          maxFontSize: 6.sw.roundToDouble(),
                          minFontSize: 3.sw.roundToDouble(),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 35,),
                      Center(
                        child: TripleBuilder(
                          store: store,
                          builder: (context, triple) => Opacity(
                              opacity: triple.isLoading ? 0.5 : 1,
                              child: SelectAvatarWidget(enable: !triple.isLoading)
                          ),
                        ),
                      ),
                      const SizedBox(height: 30,),
                      TripleBuilder(
                          store: store,
                          builder: (context, triple) => TextFieldWidget(
                            hint: 'Nome de usuário',
                            enable: !triple.isLoading,
                            icon: const Icon(Icons.person_outline, color: MyColors.textColor),
                            keyboardType: TextInputType.text,
                            maxLength: 30,
                            controller: controller.textEditingController,
                          ),
                      ),

                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TripleBuilder(
                      store: store,//the store to be observed
                      builder: (context, triple) => ButtonBlueRoundedWidget(
                        title: 'Salvar',
                        onPressed: triple.isLoading ? null : () => store.saveUserData(() => isForHome ? Navigator.of(context).pop() : controller.toSelectSoundPage())
                        ),
                      ),//called when any segment changes
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