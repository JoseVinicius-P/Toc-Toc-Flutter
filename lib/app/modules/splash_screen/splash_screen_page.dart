import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:toctoc/app/modules/splash_screen/splash_screen_controller.dart';
import 'package:toctoc/app/modules/splash_screen/splash_screen_store.dart';
import 'package:flutter/material.dart';
import 'package:toctoc/app/shared/widgets/button_blue_rounded_widget.dart';

class SplashScreenPage extends StatefulWidget {
  final String title;
  const SplashScreenPage({Key? key, this.title = 'SplashScreenPage'}) : super(key: key);
  @override
  SplashScreenPageState createState() => SplashScreenPageState();
}
class SplashScreenPageState extends State<SplashScreenPage> with WidgetsBindingObserver{
  final SplashScreenStore store = Modular.get();
  final controller = Modular.get<SplashScreenController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state != AppLifecycleState.resumed){
      SystemNavigator.pop();
    }
    super.didChangeAppLifecycleState(state);
  }


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
                    ButtonBlueRoundedWidget(title: 'Vamos começar', onPressed: () => controller.toLoginModule(),),
                  ],
                ),
              ),
            )
          ],
        )
    );
  }
}