import 'dart:async';

import 'package:flutter/material.dart';
import 'package:toctoc/app/shared/my_colors.dart';

class TextFieldUserWidget extends StatelessWidget {
  final String title;
  const TextFieldUserWidget({Key? key, this.title = "TextFieldUserWidget"}) : super(key: key);

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
            hintText: 'Email ou telefone',
            hintStyle: theme.textTheme.labelMedium,
            prefixIcon: const Icon(Icons.person_outline, color: MyColors.textColor,),
            filled: false,
        ),
      ),
    );
  }
}