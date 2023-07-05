import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:toctoc/app/modules/splash_screen/splashScreen_store.dart';
import 'package:flutter/material.dart';
import 'package:toctoc/app/shared/widgets/button_blue_rounded_widget.dart';
import 'package:toctoc/app/shared/my_colors.dart';

class SplashScreenPage extends StatefulWidget {
  final String title;
  const SplashScreenPage({Key? key, this.title = 'SplashScreenPage'}) : super(key: key);
  @override
  SplashScreenPageState createState() => SplashScreenPageState();
}
class SplashScreenPageState extends State<SplashScreenPage> {
  final SplashScreenStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return  Scaffold(
        resizeToAvoidBottomInset: false,
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
                    AutoSizeText(
                      'Toc toc!',
                      style: theme.textTheme.titleMedium!.copyWith(fontSize: 10.sw.roundToDouble()),
                      maxFontSize: 12.sw.roundToDouble(),
                      minFontSize: 4.sw.roundToDouble(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 20,),
                    AutoSizeText(
                      'Um toque, uma conexão instantânea. Conecte-se com seus amigos!',
                      style: theme.textTheme.titleSmall!.copyWith(fontSize: 17),
                      maxFontSize: 6.sw.roundToDouble(),
                      minFontSize: 3.sw.roundToDouble(),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ) ,
              ),
            ),
            const Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(30.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Image(
                        image: AssetImage('assets/images/capa.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ButtonBlueRoundedWidget(title: 'Criar uma conta', onPressed: (){},),
                    TextButton(
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AutoSizeText(
                          'Já tenho uma conta',
                          style: theme.textTheme.titleSmall!.copyWith(color: MyColors.blue, fontSize: 20),
                          maxFontSize: 6.sw.roundToDouble(),
                          minFontSize: 3.sw.roundToDouble(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
    );
  }
}