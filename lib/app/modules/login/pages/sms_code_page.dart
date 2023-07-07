import 'package:flutter/material.dart';

class SmsCodePage extends StatefulWidget {
  final String title;
  final String verificationId;
  const SmsCodePage({Key? key, this.title = 'SmsCodePage', required this.verificationId}) : super(key: key);
  @override
  SmsCodePageState createState() => SmsCodePageState();
}
class SmsCodePageState extends State<SmsCodePage> {
  @override
  void initState() {
    super.initState();
    print("ID: ${widget.verificationId}");
  }
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