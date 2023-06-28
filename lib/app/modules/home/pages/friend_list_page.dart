import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:toctoc/app/shared/my_colors.dart';

class FriendListPage extends StatefulWidget {
  final String title;
  const FriendListPage({Key? key, this.title = 'FriendListPage'}) : super(key: key);
  @override
  FriendListPageState createState() => FriendListPageState();
}
class FriendListPageState extends State<FriendListPage> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: MyColors.lightGray.withOpacity(0.7),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: TextFormField(
                  onChanged: (text){},
                  //definindo estilo do texto
                  style: theme.textTheme.labelMedium!.copyWith(fontSize: 15),
                  cursorColor: MyColors.textColor,
                  //retirando autocorreção de texto
                  autocorrect: false,
                  //definindo estilo do container do textfield
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    //Definindo hint usando varivel da classe personalizada MyStrings
                    hintText: 'Pesquisar amigo',
                    hintStyle: theme.textTheme.labelMedium!.copyWith(color: MyColors.textColor.withOpacity(0.5)),
                    prefixIcon: Icon(Icons.search_rounded, color: MyColors.textColor.withOpacity(0.5),),
                    filled: false,
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(height: 15,),
                      AutoSizeText(
                        'Amigos',
                        style: theme.textTheme.titleSmall,
                        maxFontSize: 6.sw.roundToDouble(),
                        minFontSize: 3.sw.roundToDouble(),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 15,),
                      ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 10,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
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
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 45,
                                    height: 45,
                                    child: CircleAvatar(
                                      backgroundImage: const AssetImage('assets/images/perfil.png'),
                                      radius: 40.sw.roundToDouble(),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "José Vinícius",
                                        style: theme.textTheme.labelSmall!.copyWith(fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 5,),
                                      Text(
                                        "Última visita a 2 dias",
                                        style: theme.textTheme.labelMedium!.copyWith(fontSize: 12, color: MyColors.textColor.withOpacity(0.5)),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Icon(Icons.notifications_active_outlined, color: MyColors.blue.withOpacity(0.5), size: 27,),
                                  SizedBox(width: 10,),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 15);
                        },
                      ),
                      SizedBox(height: 15,),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}