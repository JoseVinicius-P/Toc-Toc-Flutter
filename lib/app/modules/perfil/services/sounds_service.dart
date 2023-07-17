import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';

class SoundsService {
  late AudioPlayer currentPlayer = AudioPlayer();

  Future<List<String>> findSounds(BuildContext context) async {
    var manifest =
    await DefaultAssetBundle.of(context).loadString('AssetManifest.json');

    Map map = json.decode(manifest);
    List<String> values = map.keys
        .where((k) => k.contains('assets/sounds'))
        .map((dynamic key) => key.toString())
        .toList();

    return values;
  }

  void playSound(String path, Function() audioComplete) async {
    pauseCurrentSound();
    await currentPlayer.setAsset(path);
    await currentPlayer.play();
    currentPlayer.playerStateStream.listen((event) {
      if (event.processingState == ProcessingState.completed) {
        audioComplete();
      }
    });
  }

  void pauseCurrentSound(){
    currentPlayer.pause();
  }

}