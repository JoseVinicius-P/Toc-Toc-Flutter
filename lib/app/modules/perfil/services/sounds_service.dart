import 'dart:convert';

import 'package:flutter/cupertino.dart';

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

}