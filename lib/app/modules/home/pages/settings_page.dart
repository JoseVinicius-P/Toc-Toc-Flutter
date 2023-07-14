import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:toctoc/app/modules/perfil/widgets/select_avatar_widget.dart';
import 'package:toctoc/app/shared/my_colors.dart';

class SettingsPage extends StatefulWidget {
  final String title;
  const SettingsPage({Key? key, this.title = 'SettingsPage'}) : super(key: key);
  @override
  SettingsPageState createState() => SettingsPageState();
}
class SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            color: Colors.white,
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  const Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SelectAvatarWidget(enable: true,),
                    ],
                  ),
                  const SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.person_outline, color: Colors.grey),
                      const SizedBox(width: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            'Nome',
                            style: theme.textTheme.titleSmall!.copyWith(fontSize: 13, color: Colors.grey),
                            maxFontSize: 6.sw.roundToDouble(),
                            minFontSize: 3.sw.roundToDouble(),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(height: 5,),
                          AutoSizeText(
                            'José Vinícius',
                            style: theme.textTheme.titleSmall!.copyWith(fontSize: 18),
                            maxFontSize: 6.sw.roundToDouble(),
                            minFontSize: 3.sw.roundToDouble(),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const Spacer(),
                      Icon(Icons.edit, color: MyColors.blue),
                      SizedBox(width: 10,),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  const Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(Icons.person, color: Colors.transparent),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Divider(
                          color: MyColors.lightGray,  // Cor do divisor
                          height: 1,  // Altura do divisor
                          thickness: 1,  // Espessura do divisor
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.notifications_active_outlined, color: Colors.grey),
                      const SizedBox(width: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            'Som da notificação',
                            style: theme.textTheme.titleSmall!.copyWith(fontSize: 13, color: Colors.grey),
                            maxFontSize: 6.sw.roundToDouble(),
                            minFontSize: 3.sw.roundToDouble(),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(height: 5,),
                          AutoSizeText(
                            'Toc Toc',
                            style: theme.textTheme.titleSmall!.copyWith(fontSize: 18),
                            maxFontSize: 6.sw.roundToDouble(),
                            minFontSize: 3.sw.roundToDouble(),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const Spacer(),
                      Icon(Icons.edit, color: MyColors.blue),
                      SizedBox(width: 10,),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  const Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(Icons.person, color: Colors.transparent),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Divider(
                          color: MyColors.lightGray,  // Cor do divisor
                          height: 1,  // Altura do divisor
                          thickness: 1,  // Espessura do divisor
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on_outlined, color: Colors.grey),
                      const SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              'Localização da sua casa',
                              style: theme.textTheme.titleSmall!.copyWith(fontSize: 13, color: Colors.grey),
                              maxFontSize: 6.sw.roundToDouble(),
                              minFontSize: 3.sw.roundToDouble(),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(height: 5,),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(15),
                                      ),
                                      border: Border.all(
                                        width: 1,
                                        style: BorderStyle.solid,
                                        color: MyColors.lightGray,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(15),
                                      ),
                                      child: Image(
                                        height: 8.sh,
                                        image: const AssetImage('assets/images/map.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 15,),
                      Icon(Icons.edit, color: MyColors.blue),
                      SizedBox(width: 10,),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  const Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(Icons.person, color: Colors.transparent),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Divider(
                          color: MyColors.lightGray,  // Cor do divisor
                          height: 1,  // Altura do divisor
                          thickness: 1,  // Espessura do divisor
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.exit_to_app, color: Colors.red, size: 20,),
                      const SizedBox(width: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            'Sair do app',
                            style: theme.textTheme.titleSmall!.copyWith(fontSize: 15, color: Colors.redAccent),
                            maxFontSize: 6.sw.roundToDouble(),
                            minFontSize: 3.sw.roundToDouble(),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ),
        ],
      ),
    );
  }
}