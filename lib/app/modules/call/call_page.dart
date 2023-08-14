import 'package:flutter_modular/flutter_modular.dart';
import 'package:toctoc/app/modules/call/call_store.dart';
import 'package:flutter/material.dart';

class CallPage extends StatefulWidget {
  final String title;
  const CallPage({Key? key, this.title = 'CallPage'}) : super(key: key);
  @override
  CallPageState createState() => CallPageState();
}
class CallPageState extends State<CallPage> {
  final CallStore store = Modular.get();

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