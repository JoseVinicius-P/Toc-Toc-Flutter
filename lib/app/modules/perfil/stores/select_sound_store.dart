import 'package:flutter/cupertino.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:toctoc/app/modules/perfil/services/sounds_service.dart';

class SelectSoundStore extends Store<List<String>> {

  final SoundsService service;

  SelectSoundStore(this.service) : super([]);

  void findSounds(BuildContext context) async {
    update(await service.findSounds(context));
  }

}