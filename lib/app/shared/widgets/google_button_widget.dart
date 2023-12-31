import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:toctoc/app/shared/my_colors.dart';

class GoogleButtonWidget extends StatefulWidget {
  final String title;
  final Function? onTap;
  const GoogleButtonWidget({Key? key, this.title = "GoogleButtonWidget", required this.onTap}) : super(key: key);


  @override
  State<GoogleButtonWidget> createState() => _GoogleButtonWidgetState();
}

class _GoogleButtonWidgetState extends State<GoogleButtonWidget> {

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var buttonWidth = 50.sw.roundToDouble();
    var buttonHeight = buttonWidth/4.roundToDouble();
    var radius = buttonHeight/3.roundToDouble();

    Widget getGoogleButton(bool isPortrait){
      return Opacity(
        opacity: widget.onTap != null ? 1 : 0.5,
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          //Se a authenticação estiver sendo feita o botão não funcionará
          onTap: widget.onTap != null ? () => widget.onTap!() : null,
          child: Container(
            height: buttonHeight,
            width: buttonWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(radius),
              ),
            ),
            child: SizedBox.expand(
              child: Container(
                decoration: BoxDecoration(
                  color: MyColors.lightGray.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(radius),
                ),
                child: Padding(
                  padding: EdgeInsets.all(buttonHeight/5.roundToDouble()),
                  child:
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Image(
                        image: AssetImage('assets/images/icon_google.png'),
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: AutoSizeText(
                          maxLines: 1,
                          minFontSize: 2.5.sw.roundToDouble(),
                          'Entrar com o google',
                          style: theme.textTheme.labelMedium!.copyWith(fontSize: 5.sw.roundToDouble()),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return OrientationLayoutBuilder(
      portrait: (context) => getGoogleButton(true),
      landscape: (context) => getGoogleButton(false),
    );
  }
}