import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:toctoc/app/modules/perfil/perfil_controller.dart';
import 'package:toctoc/app/modules/perfil/perfil_store.dart';
import 'package:toctoc/app/modules/perfil/user_model.dart';
import 'package:toctoc/app/shared/my_colors.dart';
import 'package:latlong2/latlong.dart';

class PerfilPage extends StatefulWidget {
  final String title;
  const PerfilPage({Key? key, this.title = 'SettingsPage'}) : super(key: key);
  @override
  PerfilPageState createState() => PerfilPageState();
}
class PerfilPageState extends State<PerfilPage> {
  final controller = Modular.get<PerfilController>();
  final store = Modular.get<PerfilStore>();

  @override
  void initState() {
    super.initState();
    store.getUserData();
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
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TripleBuilder(
                    store: store,
                    builder: (context, triple){
                      UserModel user = triple.state as UserModel;
                      return Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 40.sw.roundToDouble(),
                                height: 40.sw.roundToDouble(),
                                child:  CircleAvatar(
                                  backgroundImage: const AssetImage('assets/images/perfil.png'),
                                  foregroundImage: const NetworkImage(
                                    "https://firebasestorage.googleapis.com/v0/b/toctoc-cfeaf.appspot.com/o/profile_pictures%2FLOcom3w8CXhimPWPuyJVFDE51S83.jpg?alt=media&token=f79a11e1-2bb2-4f9d-b0c9-f25d8603c26b",
                                  ),
                                  radius: 40.sw.roundToDouble(),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.person_outline, color: Colors.grey),
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
                                    user.name,
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
                              IconButton(onPressed: () => Navigator.of(context).pushNamed('./your_data'), icon: const Icon(Icons.edit, color: MyColors.blue)),
                              const SizedBox(width: 10,),
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
                              const Icon(Icons.notifications_active_outlined, color: Colors.grey),
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
                                    user.sound.replaceAll('.mp3', ''),
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
                              IconButton(onPressed: () => Navigator.of(context).pushNamed('./select_sound'), icon: const Icon(Icons.edit, color: MyColors.blue)),
                              const SizedBox(width: 10,),
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
                              const Icon(Icons.location_on_outlined, color: Colors.grey),
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
                                              child: SizedBox(
                                                height: 100,
                                                child: FlutterMap(
                                                  mapController: controller.mapController,
                                                  options: MapOptions(
                                                    center: LatLng(user.location.latitude, user.location.longitude),
                                                    zoom: 16.0,
                                                    maxZoom: 16.0,
                                                    minZoom: 16.0,
                                                    interactiveFlags: InteractiveFlag.none,
                                                  ),
                                                  nonRotatedChildren: [
                                                    TileLayer(
                                                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                                      userAgentPackageName: 'com.example.app',
                                                    ),
                                                    MarkerLayer(
                                                      markers: [
                                                        Marker(
                                                          point: LatLng(user.location.latitude, user.location.longitude),
                                                          width: 20,
                                                          height: triple.isLoading ? 20 : 62,
                                                          builder: (context) => triple.isLoading ?
                                                          const CircularProgressIndicator(color: MyColors.blue,) :
                                                          const Image(
                                                            image: AssetImage('assets/images/marker.png'),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 15,),
                              IconButton(onPressed: () => Navigator.of(context).pushNamed('./set_home'), icon: const Icon(Icons.edit, color: MyColors.blue)),
                              const SizedBox(width: 10,),
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
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.exit_to_app, color: Colors.red, size: 20,),
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