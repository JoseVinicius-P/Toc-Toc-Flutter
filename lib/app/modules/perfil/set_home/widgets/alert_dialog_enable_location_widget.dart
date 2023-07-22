import 'package:flutter/material.dart';
import 'package:toctoc/app/shared/my_colors.dart';

class AlertDialogEnableLocationWidget extends StatelessWidget {
  final String title;
  const AlertDialogEnableLocationWidget({Key? key, this.title = "AlertDialogLoactionWidget"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme =  Theme.of(context);
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Column(
        children: [
          const Icon(Icons.location_on_outlined, color: MyColors.blue, size: 30,),
          Text(
            'Ative sua localização',
            style: theme.textTheme.titleSmall!.copyWith(color: MyColors.blue),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Sua localização está desativada, ative e depois toque em Continuar!',
            style: theme.textTheme.titleSmall!.copyWith(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: <Widget>[
        Expanded(
          child: TextButton(
            child: const Text(
              'Continuar',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: MyColors.textColor,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
              ],
    );
  }
}