import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:toctoc/app/modules/perfil/your_data/stores/select_avatar_store.dart';
import 'package:toctoc/app/shared/my_colors.dart';

class SelectAvatarWidget extends StatefulWidget {
  final String title;
  final bool enable;
  const SelectAvatarWidget({Key? key, this.title = "SelectAvatarWidget", required this.enable}) : super(key: key);

  @override
  State<SelectAvatarWidget> createState() => _SelectAvatarWidgetState();
}

class _SelectAvatarWidgetState extends State<SelectAvatarWidget> {
  final store = Modular.get<SelectAvatarStore>();
  bool enable = true;

  @override
  void initState() {
    super.initState();
    enable = widget.enable;
  }

  @override
  Widget build(BuildContext context) {
    return TripleBuilder(
      store: store,
      builder: (context, triple) {
        enable = !triple.isLoading;
        return Opacity(
          opacity: enable ? 1 : 0.5,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 40.sw.roundToDouble(),
                    height: 40.sw.roundToDouble(),
                    child: CircleAvatar(
                      backgroundImage: const AssetImage('assets/images/perfil.png'),
                      foregroundImage: triple.state.toString().startsWith('http') ? CachedNetworkImageProvider(triple.state.toString()) as ImageProvider : FileImage(File(triple.state.toString())),
                      radius: 40.sw.roundToDouble(),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    right: -15,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.blue, // Altera a cor de fundo
                        shape: const CircleBorder(),
                        disabledBackgroundColor: MyColors.blue,
                      ),
                      onPressed: enable ? () => store.pickImage() : null,
                      child: const Padding(
                        padding: EdgeInsets.all(13.0),
                        child: Icon(Icons.camera_alt_outlined, color: Colors.white70,),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      }
    );
  }
}