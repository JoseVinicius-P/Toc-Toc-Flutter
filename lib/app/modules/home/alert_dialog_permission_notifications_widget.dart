import 'package:flutter/material.dart';
import 'package:toctoc/app/shared/my_colors.dart';

class AlertDialogPermissionNotificationsWidget extends StatelessWidget {
  final String title;
  const AlertDialogPermissionNotificationsWidget({Key? key, this.title = "AlertDialogEnableNotificationsWidget"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme =  Theme.of(context);
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Column(
        children: [
          const Icon(Icons.notification_important_outlined, color: MyColors.blue, size: 30,),
          Text(
            'Precisamos te enviar notificações',
            style: theme.textTheme.titleSmall!.copyWith(color: MyColors.blue),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Para te avisar quando seus amigos estiverem te visitando precisamos de algums permissões!',
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
                  'Não vou receber visitas',
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