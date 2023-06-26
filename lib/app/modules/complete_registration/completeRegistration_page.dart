import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:toctoc/app/modules/complete_registration/completeRegistration_store.dart';
import 'package:flutter/material.dart';
import 'package:toctoc/app/modules/complete_registration/complete_registration_controller.dart';
import 'package:toctoc/app/shared/my_colors.dart';

class CompleteRegistrationPage extends StatefulWidget {
  final String title;
  const CompleteRegistrationPage({Key? key, this.title = 'CompleteRegistrationPage'}) : super(key: key);
  @override
  CompleteRegistrationPageState createState() => CompleteRegistrationPageState();
}

class CompleteRegistrationPageState extends State<CompleteRegistrationPage> {
  final CompleteRegistrationStore store = Modular.get();
  final controller = Modular.get<CompleteRegistrationController>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
              onPressed: () => Modular.to.pop(),
              icon: const Icon(Icons.close, color: Colors.black)
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
              padding: EdgeInsets.all(30.0),
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
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              children: [
                                SizedBox(
                                  width: 40.sw.roundToDouble(),
                                  height: 40.sw.roundToDouble(),
                                  child: CircleAvatar(
                                    backgroundImage: const AssetImage('assets/images/perfil.png'),
                                    radius: 40.sw.roundToDouble(),
                                  ),
                                ),
                                Positioned(
                                  bottom: 5,
                                  right: -15,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: MyColors.blue, // Altera a cor de fundo
                                      shape: CircleBorder(),
                                    ),
                                    onPressed: (){},
                                    child: const Padding(
                                      padding: EdgeInsets.all(13.0),
                                      child: Icon(Icons.camera_alt_outlined, color: Colors.white70,),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
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
                            hintText: 'Nome',
                            hintStyle: theme.textTheme.labelMedium,
                            prefixIcon: const Icon(Icons.person_outline, color: MyColors.textColor,),
                            filled: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: MyColors.blue, // Altera a cor de fundo
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                              onPressed: () => controller.toSelectSoundPage(),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AutoSizeText(
                                  'Salvar',
                                  style: theme.textTheme.titleMedium!.copyWith(color: Colors.white, fontSize: 25),
                                  maxFontSize: 6.sw.roundToDouble(),
                                  minFontSize: 3.sw.roundToDouble(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ],
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