import 'package:flutter_modular/flutter_modular.dart';
import 'package:toctoc/app/modules/create_account/createAccount_store.dart';
import 'package:flutter/material.dart';

class CreateAccountPage extends StatefulWidget {
  final String title;
  const CreateAccountPage({Key? key, this.title = 'CreateAccountPage'}) : super(key: key);
  @override
  CreateAccountPageState createState() => CreateAccountPageState();
}
class CreateAccountPageState extends State<CreateAccountPage> {
  final CreateAccountStore store = Modular.get();

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