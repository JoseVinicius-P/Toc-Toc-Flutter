import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:toctoc/app/modules/set_home/setHome_store.dart';
import 'package:flutter/material.dart';
import 'package:toctoc/app/shared/my_colors.dart';
import 'package:toctoc/app/shared/widgets/button_blue_rounded_widget.dart';

class SetHomePage extends StatefulWidget {
  final String title;
  const SetHomePage({Key? key, this.title = 'SetHomePage'}) : super(key: key);
  @override
  SetHomePageState createState() => SetHomePageState();
}
class SetHomePageState extends State<SetHomePage> {
  final SetHomeStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
              onPressed: () => Modular.to.pop(),
              icon: const Icon(Icons.close, color: Colors.black)
          ),
          forceMaterialTransparency: true,
          title: Text(
            "Localização da sua casa",
            style: theme.textTheme.titleSmall!.copyWith(color: MyColors.blue),
          ),
        ),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              color: Colors.white,
            ),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: SafeArea(
                child: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AutoSizeText(
                                'A localização será usada para que seus amigos possam tocar a "campainha", quando estiverem próximos!',
                                style: theme.textTheme.titleSmall!.copyWith(fontSize: 18),
                                maxFontSize: 6.sw.roundToDouble(),
                                minFontSize: 3.sw.roundToDouble(),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 5,),
                              AutoSizeText(
                                '*Você deve estar em casa para definir a localização!',
                                style: theme.textTheme.titleSmall!.copyWith(fontSize: 13, color: Colors.red),
                                maxFontSize: 6.sw.roundToDouble(),
                                minFontSize: 3.sw.roundToDouble(),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Flexible(
                          child: Container(
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
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                              child: Image(
                                height: 60.sh,
                                width: double.infinity,
                                image: const AssetImage('assets/images/map.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AutoSizeText(
                                  'Mais tarde',
                                  style: theme.textTheme.titleSmall!.copyWith(color: MyColors.blue, fontSize: 20),
                                  maxFontSize: 6.sw.roundToDouble(),
                                  minFontSize: 3.sw.roundToDouble(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                          ),
                          Expanded(child: ButtonBlueRoundedWidget(title: 'Salvar', onPressed: () {})),
                        ],
                      ),
                    ),
                  ],
                ) ,
              ),
            ),
          ],
        )
    );
  }
}