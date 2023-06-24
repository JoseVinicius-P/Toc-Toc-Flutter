import 'dart:async';

import 'package:flutter/material.dart';
import 'package:toctoc/app/shared/my_colors.dart';

class TextFieldPasswordWidget extends StatelessWidget {
  final String title;
  const TextFieldPasswordWidget({Key? key, this.title = "TextFieldPasswordWidget"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Timer? delay;


    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
        border: Border.all(
          width: 1,
          style: BorderStyle.solid,
          color: Colors.grey,
        ),
      ),
      child: TextFormField(
        obscureText: true,
        onChanged: (text){}
        /*(text){
          delay?.cancel();
          delay = Timer(const Duration(milliseconds: 1000), () {
            if(text.length >= 3){
              widget.onTextChange(text);
            }
          });
        }*/,
        //definindo estilo do texto
        style: theme.textTheme.labelMedium,
        cursorColor: MyColors.textColor,
        //retirando autocorreção de texto
        autocorrect: false,
        //definindo estilo do container do textfield
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(30),
          ),
          //Definindo hint usando varivel da classe personalizada MyStrings
          hintText: 'Senha',
          hintStyle: theme.textTheme.labelMedium,
          prefixIcon: const Icon(Icons.lock_open_outlined, color: MyColors.textColor,),
          suffixIcon: IconButton(icon: Icon(Icons.visibility_off_outlined, color: MyColors.textColor,), onPressed: () {  },),
          filled: false,
        ),
      ),
    );
  }
}