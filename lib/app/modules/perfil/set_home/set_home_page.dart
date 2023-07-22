import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:toctoc/app/modules/perfil/set_home/widgets/alert_dialog_enable_location_widget.dart';
import 'package:toctoc/app/modules/perfil/set_home/widgets/alert_dialog_permission_location_widget.dart';
import 'package:toctoc/app/modules/perfil/set_home/set_home_store.dart';
import 'package:flutter/material.dart';
import 'package:toctoc/app/modules/perfil/set_home/set_home_controller.dart';
import 'package:toctoc/app/shared/my_colors.dart';
import 'package:toctoc/app/shared/widgets/button_blue_rounded_widget.dart';
import 'package:latlong2/latlong.dart';

class SetHomePage extends StatefulWidget {
  final String title;
  const SetHomePage({Key? key, this.title = 'SetHomePage'}) : super(key: key);
  @override
  SetHomePageState createState() => SetHomePageState();
}
class SetHomePageState extends State<SetHomePage> {
  final store = Modular.get<SetHomeStore>();
  final controller = Modular.get<SetHomeController>();

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  /*O fluxo é o seguinte:
  1 - Verifica se a Localização já foi permitida
  2 - Se sim consulta se não
  3 - Exibe uma Dialog explicando e pedindo a permissão
  4 - Se não retorna false e o app é fechado
  5 - Se for dada a caixa do sistema é aberta para permissão
  6 - Se na caixa do sistema for negada o fluxo se repete
  */
  void getLocation() async {
    if(await store.isLocationEnabled()){
      if(await store.permissionLocationIsAllowed()){
        store.getPosition();
      }else{
        if(await alertDialogPermissionLocationWidget()){
          if(await store.requestLocationPermission()){
            store.getPosition();
          }else{
            getLocation();
          }
        }else{
          SystemNavigator.pop();
        }
      }
    }else{
      await alertDialogEnableLocationWidget();
      getLocation();
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black)
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
              padding: const EdgeInsets.all(30.0),
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
                              const SizedBox(height: 5,),
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
                        const SizedBox(height: 20,),
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
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15),
                              ),
                              child: _buildMap(),
                              /*Image(
                                height: 60.sh,
                                width: double.infinity,
                                image: const AssetImage('assets/images/map.jpg'),
                                fit: BoxFit.cover,
                              ),*/
                            ),
                          ),
                        ),
                        const SizedBox(height: 70,),
                      ],
                    ),
                    TripleBuilder(
                      store: store,
                      builder: (context, triple) {
                        return Align(
                          alignment: Alignment.bottomRight,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Opacity(
                                  opacity: triple.isLoading ? 0.5 : 1,
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
                              ),
                              Expanded(
                                child: ButtonBlueRoundedWidget(
                                    title: 'Salvar',
                                    onPressed: triple.isLoading ? null : () => store.saveLocation()
                                )
                              ),
                            ],
                          ),
                        );
                      }
                    ),
                  ],
                ) ,
              ),
            ),
          ],
        )
    );
  }

  Future<bool> alertDialogPermissionLocationWidget() async {
    return await showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.4),
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialogPermissionLocationWidget();
      },
    );
  }

  Future<void> alertDialogEnableLocationWidget() async {
    return await showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.4),
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialogEnableLocationWidget();
      },
    );
  }

  // Método para construir o mapa
  Widget _buildMap() {
      return TripleBuilder(
        store: store,
        builder: (context, triple) {
          return Opacity(
            opacity: triple.isLoading ? 0.5 : 1,
            child: FlutterMap(
              mapController: controller.mapController,
              options: MapOptions(
                center: triple.state as LatLng,
                zoom: 18.0,
                maxZoom: 18.0,
                minZoom: 18.0,
                interactiveFlags: InteractiveFlag.none
              ),
              nonRotatedChildren: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: triple.state as LatLng,
                      width: 33,
                      height: triple.isLoading ? 33 : 100,
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
          );
        }
      );
  }
}