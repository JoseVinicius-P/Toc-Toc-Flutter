import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:toctoc/app/shared/my_colors.dart';

class TextFieldWidget extends StatefulWidget {
  final String title;
  final String hint;
  final bool enable;
  final String? error;
  final MaskTextInputFormatter? maskFormatter;
  final IconData icon;
  final TextInputType keyboardType;
  final int? maxLength;
  final TextEditingController? controller;

  const TextFieldWidget({
    Key? key, this.title = "TextFieldUserWidget",
    required this.hint,
    this.maskFormatter,
    required this.enable,
    required this.icon,
    required this.keyboardType,
    this.maxLength,
    this.controller,
    this.error
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            border: Border.all(
              width: 1,
              style: BorderStyle.solid,
              color: widget.error == null || widget.error == "" ? Colors.grey : MyColors.errorRed,
            ),
          ),
          child: TextFormField(
            controller: widget.controller,
            maxLengthEnforcement: MaxLengthEnforcement.none,
            enabled: widget.enable,
            inputFormatters: widget.maskFormatter != null ?
            [
              widget.maskFormatter!,
              LengthLimitingTextInputFormatter(widget.maxLength),
            ] :
            [
              LengthLimitingTextInputFormatter(widget.maxLength)
            ],
            keyboardType: widget.keyboardType,
            onChanged: (text){},
            //definindo estilo do texto
            style: theme.textTheme.labelMedium,
            cursorColor: MyColors.textColor,
            //retirando autocorreção de texto
            autocorrect: false,
            //definindo estilo do container do textfield
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 17.0),
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
              hintStyle: theme.textTheme.labelMedium!.copyWith(color: widget.error == null || widget.error == "" ? MyColors.textColor : MyColors.errorRed),
              prefixIcon: Icon(widget.icon, color: widget.error == null || widget.error == "" ? MyColors.textColor : MyColors.errorRed),
              filled: false,
            ),
          ),
        ),
        const SizedBox(height: 5,),
        Text(
        widget.error != null && widget.error != "" ? "     *${widget.error}" : "",
          style: const TextStyle(
            color: MyColors.errorRed
          ),
        )
      ],
    );
  }
}