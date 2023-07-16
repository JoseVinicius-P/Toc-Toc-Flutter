import 'package:flutter_triple/flutter_triple.dart';
import 'package:toctoc/app/modules/perfil/services/sounds_service.dart';

class SoundReproductionStore extends Store<int> {
  final SoundsService soundsService;

  SoundReproductionStore(this.soundsService) : super(0);

  void playSound(String path, int index) async {
    update(index);
    setLoading(true);
    await soundsService.playSound(path);
    setLoading(false);
  }

}