import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:toctoc/app/shared/my_colors.dart';

class AlertDialogLocationWidget extends StatelessWidget {
  final String title;
  const AlertDialogLocationWidget({Key? key, this.title = "AlertDialogLoactionWidget"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme =  Theme.of(context);
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        'Precisamos da sua localização',
        style: theme.textTheme.titleSmall,
        textAlign: TextAlign.center,
      ),
      content: AutoSizeText(
        'SUa localização será usada para que seus amigos possam tocar a "campainha" quando estiverem próximos!',
        style: theme.textTheme.titleSmall!.copyWith(fontSize: 18),
        maxFontSize: 6.sw.roundToDouble(),
        minFontSize: 3.sw.roundToDouble(),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'Não permitir e fechar app',
            style: TextStyle(
              color: MyColors.textColor,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        TextButton(
          onPressed: (){
            Navigator.of(context).pop(true);
          },
          child: const Text(
            'Permitir',
            style: TextStyle(
              color: MyColors.textColor,
            ),
          ),
        ),
      ],
    );
  }
}