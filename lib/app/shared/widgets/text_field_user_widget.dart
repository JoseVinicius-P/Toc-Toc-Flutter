import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:toctoc/app/shared/my_colors.dart';

class TextFieldUserWidget extends StatefulWidget {
  final String title;
  final String hint;
  final bool enable;
  final MaskTextInputFormatter maskFormatter;

  const TextFieldUserWidget({Key? key, this.title = "TextFieldUserWidget", required this.hint, required this.maskFormatter, required this.enable}) : super(key: key);

  @override
  State<TextFieldUserWidget> createState() => _TextFieldUserWidgetState();
}

class _TextFieldUserWidgetState extends State<TextFieldUserWidget> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        border: Border.all(
          width: 1,
          style: BorderStyle.solid,
          color: Colors.grey,
        ),
      ),
      child: TextFormField(
        enabled: widget.enable,
        inputFormatters: [widget.maskFormatter],
        keyboardType: TextInputType.number,
        onChanged: (text){},
        //definindo estilo do texto
        style: theme.textTheme.labelMedium,
        cursorColor: MyColors.textColor,
        //retirando autocorreção de texto
        autocorrect: false,
        //definindo estilo do container do textfield
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 17.0),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(15),
            ),
            //Definindo hint usando varivel da classe personalizada MyStrings
            hintText: widget.hint,
            hintStyle: theme.textTheme.labelMedium,
            prefixIcon: const Icon(Icons.phone_rounded, color: MyColors.textColor,),
            filled: false,
        ),
      ),
    );
  }
}