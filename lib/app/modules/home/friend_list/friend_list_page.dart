import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:toctoc/app/modules/home/friend_list/friend_item_widget.dart';
import 'package:toctoc/app/modules/home/friend_list/stores/friend_list_store.dart';
import 'package:toctoc/app/modules/home/friend_list/stores/select_friend_store.dart';
import 'package:toctoc/app/modules/home/friend_model.dart';
import 'package:toctoc/app/shared/my_colors.dart';

class FriendListPage extends StatefulWidget {
  final String title;
  const FriendListPage({Key? key, this.title = 'FriendListPage'}) : super(key: key);
  @override
  FriendListPageState createState() => FriendListPageState();
}
class FriendListPageState extends State<FriendListPage> {
  final friendListStore = Modular.get<FriendListStore>();
  final selectFriendStore = Modular.get<SelectFriendStore>();

  @override
  void initState() {
    super.initState();
    friendListStore.loadFriends();
  }

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
                  const SizedBox(height: 10,),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const SizedBox(height: 15,),
                          AutoSizeText(
                            'Amigos',
                            style: theme.textTheme.titleSmall,
                            maxFontSize: 6.sw.roundToDouble(),
                            minFontSize: 3.sw.roundToDouble(),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 15,),
                          TripleBuilder(
                            store: friendListStore,
                            builder: (context, tripleFriendList) {
                              List<FriendModel> friends = tripleFriendList.state as List<FriendModel>;
                              return ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: friends.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return TripleBuilder(
                                    store: selectFriendStore,
                                    builder: (context, tripleSelectFriend) {
                                      return InkWell(
                                        onTap: (){
                                          String data = jsonEncode({
                                            'name': friends[index].name,
                                            'profilePictureUrl': friends[index].profilePictureUrl,
                                            'friendUid': friends[index].uid
                                          });
                                          Modular.to.pushNamed('/call/', arguments: {
                                            'data' : data,
                                            'receivingCall': false,
                                          });
                                        },
                                        child: FriendItem(
                                          friend: friends[index],
                                          inCall: tripleSelectFriend.state as FriendModel == friends[index],
                                        )
                                      );
                                    }
                                  );
                                },
                                separatorBuilder: (BuildContext context, int index) {
                                  return const SizedBox(height: 15);
                                },
                              );
                            }
                          ),
                          const SizedBox(height: 15,),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}