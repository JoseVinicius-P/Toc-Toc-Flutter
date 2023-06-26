import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute('/');
    return MaterialApp.router(
      title: 'Toctoc',
      theme: ThemeData(
        primaryColor: const Color(0xFF771F98),
        textTheme: const TextTheme(
          //TextField
            labelMedium: TextStyle(color: Color(0xFF635C5C), fontSize: 17),
            //Titulo fino sem negrito
            titleSmall: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w300),
            //titulo bold com negrito
            titleMedium: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
            //texto normal
            labelSmall: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.normal)
        ),
      ),
      routerDelegate: Modular.routerDelegate,
      routeInformationParser: Modular.routeInformationParser,
    );
  }
}