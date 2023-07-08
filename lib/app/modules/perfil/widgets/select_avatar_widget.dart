import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:toctoc/app/shared/my_colors.dart';

class SelectAvatarWidget extends StatelessWidget {
  final String title;
  const SelectAvatarWidget({Key? key, this.title = "SelectAvatarWidget"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            SizedBox(
              width: 40.sw.roundToDouble(),
              height: 40.sw.roundToDouble(),
              child: CircleAvatar(
                backgroundImage: const AssetImage('assets/images/perfil.png'),
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
                ),
                onPressed: (){},
                child: const Padding(
                  padding: EdgeInsets.all(13.0),
                  child: Icon(Icons.camera_alt_outlined, color: Colors.white70,),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}