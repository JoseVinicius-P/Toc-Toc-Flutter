import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:toctoc/app/modules/login/login_store.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key? key, this.title = 'LoginPage'}) : super(key: key);
  @override
  LoginPageState createState() => LoginPageState();
}
class LoginPageState extends State<LoginPage> {
  final LoginStore store = Modular.get();

  @override
  Widget build(BuildContext context) {

    Widget getScaffold(bool isPortrait, BuildContext context){
      var theme = Theme.of(context);
      return Scaffold(
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                color: Colors.white,
              ),
              Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Opacity(
                        opacity: 0.3,
                        child: Container(
                          child: isPortrait ?
                          Image(
                            height: 70.sh,
                            image: const AssetImage('assets/images/capa_login.png'),
                            fit: BoxFit.cover,
                          ) :
                          Expanded(child:
                            Image(
                              width: 60.sh,
                              image: const AssetImage('assets/images/capa_login_landscape.png'),
                              fit: BoxFit.cover,
                            )
                          ),
                        ),
                      ),
                    ],
                  ),
                  SafeArea(
                    child: Row(
                      mainAxisAlignment: isPortrait ? MainAxisAlignment.center : MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Column(
                            mainAxisAlignment: isPortrait ? MainAxisAlignment.end : MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: AutoSizeText(
                                  'Campainha virtual',
                                  style: theme.textTheme.titleMedium!.copyWith(fontSize: 8.sw.roundToDouble()),
                                  maxFontSize: 8.sw.roundToDouble(),
                                  minFontSize: 4.sw.roundToDouble(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 3.0, bottom: 5.0, left: 5.0),
                                child: SizedBox(
                                  width: 40.sw.roundToDouble(),
                                  child: AutoSizeText(
                                    'Avise seus amigos sobre uma visita tocando a campainha',
                                    maxLines: 2,
                                    softWrap: true,
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.titleSmall!.copyWith(fontSize: 5.sw.roundToDouble()),
                                    maxFontSize: 5.sw.roundToDouble(),
                                    minFontSize: 2.3.sw.roundToDouble(),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              Container(
                                child: isPortrait ? SizedBox(height: 10.sh) : const SizedBox(),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: isPortrait ? const SizedBox(height: 0) : SizedBox(width: 25.sw),
                        ),
                      ],
                    ),
                  ),
                ],
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