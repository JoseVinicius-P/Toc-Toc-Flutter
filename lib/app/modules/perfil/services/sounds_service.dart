import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';

class SoundsService {

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

  Future<bool> playSound(String path) async {
    bool isCompleted = false;
    AudioPlayer audioPlayer = AudioPlayer();
    await audioPlayer.setAsset(path);
    await audioPlayer.play();
    audioPlayer.playerStateStream.listen((event) {
      if (event.processingState == ProcessingState.completed) {
        isCompleted = true;
      }
    });
    return isCompleted;
  }

}