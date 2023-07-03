import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:toctoc/app/shared/my_colors.dart';

class ButtonBlueRoundedWidget extends StatefulWidget {
  final Function? onPressed;
  final String title;
  const ButtonBlueRoundedWidget({Key? key, required this.title, required this.onPressed}) : super(key: key);

  @override
  State<ButtonBlueRoundedWidget> createState() => _ButtonBlueRoundedWidgetState();
}

class _ButtonBlueRoundedWidgetState extends State<ButtonBlueRoundedWidget> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Opacity(
      opacity: widget.onPressed != null ? 1 : 0.5,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.blue, // Altera a cor de fundo
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                disabledBackgroundColor: MyColors.blue,
              ),
              onPressed: widget.onPressed != null ? () => widget.onPressed!() : null,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AutoSizeText(
                  widget.title,
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
      ),
    );
  }
}