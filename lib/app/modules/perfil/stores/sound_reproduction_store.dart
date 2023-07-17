import 'package:flutter_triple/flutter_triple.dart';
import 'package:toctoc/app/modules/perfil/services/sounds_service.dart';
import 'package:just_audio/just_audio.dart';

class SoundReproductionStore extends Store<int> {
  final SoundsService soundsService;
  late AudioPlayer? currentAudio;

  SoundReproductionStore(this.soundsService) : super(0);

  void playSound(String path, int index) async {
    update(index);
    setLoading(true);
    soundsService.playSound(path, () => setLoading(false));
  }

  void pauseCurrentSong(){
    soundsService.pauseCurrentSound();
    setLoading(false);
  }

}