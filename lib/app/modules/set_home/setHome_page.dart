import 'package:flutter_modular/flutter_modular.dart';
import 'package:toctoc/app/modules/set_home/setHome_store.dart';
import 'package:flutter/material.dart';

class SetHomePage extends StatefulWidget {
  final String title;
  const SetHomePage({Key? key, this.title = 'SetHomePage'}) : super(key: key);
  @override
  SetHomePageState createState() => SetHomePageState();
}
class SetHomePageState extends State<SetHomePage> {
  final SetHomeStore store = Modular.get();

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