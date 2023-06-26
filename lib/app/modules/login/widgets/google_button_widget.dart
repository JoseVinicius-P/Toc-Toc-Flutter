import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:toctoc/app/shared/my_colors.dart';

class GoogleButtonWidget extends StatelessWidget {
  final String title;
  const GoogleButtonWidget({Key? key, this.title = "GoogleButtonWidget"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var buttonWidth = 50.sw.roundToDouble();
    var buttonHeight = buttonWidth/4.roundToDouble();
    var radius = buttonHeight/3.roundToDouble();

    Widget getGoogleButton(bool isPortrait){
      return InkWell(
        borderRadius: BorderRadius.circular(radius),
        //Se a authenticação estiver sendo feita o botão não funcionará
        onTap: (){}/*loginController.inAuthentication ? null : () async {
          await loginController.signInWithGoogle();
          loginController.toHomeModule();
        }*/,
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
                child: Row(
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
      );
    }

    return OrientationLayoutBuilder(
      portrait: (context) => getGoogleButton(true),
      landscape: (context) => getGoogleButton(false),
    );
  }
}