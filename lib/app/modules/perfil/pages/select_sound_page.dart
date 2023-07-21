import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:toctoc/app/modules/perfil/perfil_controller.dart';
import 'package:toctoc/app/modules/perfil/stores/select_sound_store.dart';
import 'package:toctoc/app/modules/perfil/stores/sound_reproduction_store.dart';
import 'package:toctoc/app/shared/my_colors.dart';
import 'package:toctoc/app/shared/widgets/button_blue_rounded_widget.dart';

class SelectSoundPage extends StatefulWidget {
  final String title;
  const SelectSoundPage({Key? key, this.title = 'SelectSoundPage'}) : super(key: key);
  @override
  SelectSoundPageState createState() => SelectSoundPageState();
}
class SelectSoundPageState extends State<SelectSoundPage> {
  final selectSoundStore = Modular.get<SelectSoundStore>();
  final soundReproductionStore = Modular.get<SoundReproductionStore>();
  final controller = Modular.get<PerfilController>();
  late Future<List<String>> futureSounds;
  final bool isForHome = Modular.to.path.contains('home');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureSounds = controller.findSounds(context);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
              onPressed: (){
                if(isForHome){
                  Navigator.of(context).pop();
                }else{
                  Modular.to.pop();
                }
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black)
          ),
          forceMaterialTransparency: true,
          title: Text(
            "Definir campainha",
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
                    SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: AutoSizeText(
                              'Este é o som que será tocado quando um amigo estiver à porta',
                              style: theme.textTheme.titleSmall!.copyWith(fontSize: 18),
                              maxFontSize: 6.sw.roundToDouble(),
                              minFontSize: 3.sw.roundToDouble(),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 35,),
                          FutureBuilder<List<String>>(
                            future: futureSounds,
                            builder: (context, snapshot){
                              return ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return TripleBuilder(
                                  store: selectSoundStore,
                                  builder: (context, selectSoundTriple) {
                                    return InkWell(
                                      onTap: () => selectSoundStore.selectSound(snapshot.data![index].replaceAll('assets/sounds/', '')),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(15),
                                          ),
                                          border: Border.all(
                                            width: 1,
                                            style: BorderStyle.solid,
                                            color: selectSoundTriple.state.toString().contains(snapshot.data![index].replaceAll('assets/sounds/', '')) ? MyColors.blue : MyColors.lightGray,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                snapshot.data![index].replaceAll('assets/sounds/', '').replaceAll('.mp3', ''),
                                                style: theme.textTheme.labelSmall,
                                              ),
                                              const Spacer(),
                                              TripleBuilder(
                                                store: soundReproductionStore,
                                                builder: (context, soundReproductionTriple){
                                                  late Icon icon;
                                                  late Function onPressed;
                                                  if(soundReproductionTriple.isLoading && int.parse(soundReproductionTriple.state.toString()) == index){
                                                    icon = const Icon(Icons.pause_rounded, color: MyColors.blue, size: 27,);
                                                    onPressed = () => soundReproductionStore.pauseCurrentSong();
                                                  }else{
                                                    icon = const Icon(Icons.play_arrow_rounded, color: MyColors.blue, size: 27,);
                                                    onPressed = () {
                                                      selectSoundStore.selectSound(snapshot.data![index].replaceAll('assets/sounds/', ''));
                                                      soundReproductionStore.playSound(snapshot.data![index], index);
                                                    };
                                                  }

                                                  return IconButton(
                                                      onPressed: () => onPressed(),
                                                      icon: icon
                                                  );
                                                }
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                );
                              },
                              separatorBuilder: (BuildContext context, int index) {
                                return const SizedBox(height: 5);
                              },
                                );
                            },
                          ),
                          SizedBox(height: 60,)
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ButtonBlueRoundedWidget(
                        title: 'Salvar',
                        onPressed: () => selectSoundStore.saveSound(
                                ()=> isForHome ? Navigator.of(context).pop() : controller.toSetHomeModule()
                        ),
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