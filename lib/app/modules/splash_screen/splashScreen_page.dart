import 'package:flutter_modular/flutter_modular.dart';
import 'package:toctoc/app/modules/splash_screen/splashScreen_store.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}