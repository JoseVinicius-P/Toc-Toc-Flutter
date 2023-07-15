import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:flutter_triple/flutter_triple.dart';

class SoundStore extends Store<int> {

  SoundStore() : super(-1);

  void playSound(String path) async {
    ByteData byteData = await rootBundle.load(path);
    Uint8List audioBytes = byteData.buffer.asUint8List();
    AudioPlayer audioPlayer = AudioPlayer();
    int result = await audioPlayer.playBytes(audioBytes);
  }

}