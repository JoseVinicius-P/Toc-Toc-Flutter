import 'package:flutter_triple/flutter_triple.dart';
import 'package:toctoc/app/modules/perfil/services/local_sounds_service.dart';

class SelectSoundStore extends Store<List<String>> {

  final LoacalSoundsService service;

  SelectSoundStore(this.service) : super([]);

}