import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:toctoc/app/modules/home/home_controller.dart';
import 'package:toctoc/app/modules/home/add_friend/add_friend_page.dart';
import 'package:toctoc/app/modules/home/friend_list/friend_list_page.dart';
import 'package:toctoc/app/shared/my_colors.dart';
import 'home_store.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = 'Home'}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final store = Modular.get<HomeStore>();
  final controller = Modular.get<HomeController>();

  @override
  void dispose() {
    Modular.dispose<HomeStore>();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Modular.to.navigate('./perfil');
    //controller.addPageListener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Este page view fica respnsavel por exibir as páginas e possibilitar o slide das páginas
      body: PageView(
        //Controller
        controller: controller.pageViewController,
        children: [
          FriendListPage(),
          AddFriendPage(),
          RouterOutlet(),
        ],
      ),
      //Criando o BottomNavigation
      bottomNavigationBar: AnimatedBuilder(
        //Possibilitando a troca da current page usando o controller do PageView
          animation: controller.pageViewController,
          builder: (context, snapshot) {
            return Container(
              height: 10.sh,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5.0,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
                child: BottomNavigationBar(
                  iconSize: 3.2.sh,
                  showSelectedLabels: false,
                  backgroundColor: Colors.white,
                  //Definindo atributos e icones não selecionados
                  unselectedIconTheme: const IconThemeData(
                      color: MyColors.lightGray
                  ),
                  //Não mostrar texto se item não estiver selecionado
                  showUnselectedLabels: false,
                  //Definindo item selecionado de acorddo com controlle pageViewCOntroler
                  //Está arredondando para par o inteiro mais próximo por conta do slide que o page view permite
                  currentIndex: controller.pageViewController.page?.round() ?? 0,
                  //Definido cor do item selecionado
                  selectedItemColor: MyColors.blue,
                  onTap: (index){
                    controller.pageViewController.animateToPage(index, // Índice da página para animar
                      duration: const Duration(milliseconds: 800), // Duração da animação
                      curve: Curves.easeInOutCubicEmphasized, // Curva de animação
                    );
                  },
                  //Criando Itens
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: ImageIcon(
                          AssetImage('assets/images/home_icon.png'),
                        ),
                      label: ''
                    ),
                    BottomNavigationBarItem(
                      icon: ImageIcon(
                        AssetImage('assets/images/add_friend.png'),
                      ),
                      label: ''
                    ),
                    BottomNavigationBarItem(
                        icon: ImageIcon(
                          AssetImage('assets/images/perfil_icon.png'),
                        ),
                        label: ''
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}