import 'package:flutter/material.dart';
import 'package:toctoc/app/shared/my_colors.dart';

class AlertDialogPermissionLocationWidget extends StatelessWidget {
  final String title;
  const AlertDialogPermissionLocationWidget({Key? key, this.title = "AlertDialogLoactionWidget"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme =  Theme.of(context);
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Column(
        children: [
          const Icon(Icons.location_on_outlined, color: MyColors.blue, size: 30,),
          Text(
            'Precisamos da sua localização',
            style: theme.textTheme.titleSmall!.copyWith(color: MyColors.blue),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Sua localização será usada para que seus amigos possam tocar a "campainha" quando estiverem próximos, ou para sabermos quando você está fazendo uma visita!',
            style: theme.textTheme.titleSmall!.copyWith(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: <Widget>[
        Row(
          children: [
            Expanded(
              child: TextButton(
                child: const Text(
                  'Não permitir e fechar app',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: MyColors.textColor,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: (){
                  Navigator.of(context).pop(true);
                },
                child: const Text(
                  'Permitir',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: MyColors.blue,
                    fontSize: 18
                  ),
                ),
              ),
            ),
          ],
        )

      ],
    );
  }
}