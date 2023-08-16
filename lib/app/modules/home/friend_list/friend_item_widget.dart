import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:toctoc/app/modules/home/friend_model.dart';
import 'package:toctoc/app/shared/my_colors.dart';

class FriendItem extends StatefulWidget {
  final FriendModel friend;
  final bool inCall;
  const FriendItem({
    super.key, required this.friend, required this.inCall,
  });

  @override
  State<FriendItem> createState() => _FriendItemState();
}

class _FriendItemState extends State<FriendItem> {
  @override
  Widget build(BuildContext context) {
    var theme =  Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        border: Border.all(
          width: 1,
          style: BorderStyle.solid,
          color: MyColors.lightGray,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            SizedBox(
              width: 45,
              height: 45,
              child: CircleAvatar(
                backgroundImage: const AssetImage('assets/images/perfil.png'),
                foregroundImage: CachedNetworkImageProvider(widget.friend.profilePictureUrl),
                radius: 40.sw.roundToDouble(),
              ),
            ),
            const SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.friend.name,
                  style: theme.textTheme.labelSmall!.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5,),
                Text(
                  "Última visita a 2 dias",
                  style: theme.textTheme.labelMedium!.copyWith(fontSize: 12, color: MyColors.textColor.withOpacity(0.5)),
                ),
              ],
            ),
            const Spacer(),
            Visibility(
              visible: widget.inCall,
              child: Icon(
                Icons.notifications_active_outlined,
                color: MyColors.blue.withOpacity(0.8),
                size: 27,
              ),
            ),
            const SizedBox(width: 10,),
          ],
        ),
      ),
    );
  }
}