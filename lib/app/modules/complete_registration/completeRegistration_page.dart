import 'package:flutter_modular/flutter_modular.dart';
import 'package:toctoc/app/modules/complete_registration/completeRegistration_store.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              color: Colors.white,
            ),
            const Padding(
              padding: const EdgeInsets.all(30.0),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10,),
                    const Flexible(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Image(
                          image: const AssetImage('assets/images/perfil.png'),
                          fit: BoxFit.cover,
                        ),
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