import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:toctoc/app/shared/my_colors.dart';

class ButtonBlueRoundedWidget extends StatelessWidget {
  final Function onPressed;
  final String title;
  const ButtonBlueRoundedWidget({Key? key, required this.title, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: MyColors.blue, // Altera a cor de fundo
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            onPressed: () => onPressed(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AutoSizeText(
                title,
                style: theme.textTheme.titleMedium!.copyWith(color: Colors.white, fontSize: 25),
                maxFontSize: 6.sw.roundToDouble(),
                minFontSize: 3.sw.roundToDouble(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ],
    );
  }
}