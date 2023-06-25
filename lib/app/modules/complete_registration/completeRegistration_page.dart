import 'package:flutter_modular/flutter_modular.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:toctoc/app/modules/complete_registration/completeRegistration_store.dart';
import 'package:flutter/material.dart';
import 'package:toctoc/app/shared/my_colors.dart';

class CompleteRegistrationPage extends StatefulWidget {
  final String title;
  const CompleteRegistrationPage({Key? key, this.title = 'CompleteRegistrationPage'}) : super(key: key);
  @override
  CompleteRegistrationPageState createState() => CompleteRegistrationPageState();
}
class CompleteRegistrationPageState extends State<CompleteRegistrationPage> {
  final CompleteRegistrationStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                                  backgroundImage: AssetImage('assets/images/perfil.png'),
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

                  ],
                ) ,
              ),
            ),
          ],
        )
    );
  }
}