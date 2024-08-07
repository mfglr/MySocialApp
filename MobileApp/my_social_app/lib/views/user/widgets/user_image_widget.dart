import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_social_app/state/state.dart';
import 'package:my_social_app/state/user_image_entity_state/actions.dart';

class UserImageWidget extends StatelessWidget {
  final int userId;
  final double diameter;
  const UserImageWidget({super.key, required this.userId, required this.diameter});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        shape: BoxShape.circle
      ),
      child: StoreConnector<AppState,Uint8List?>(
        onInit: (store) => store.dispatch(LoadUserImageAction(userId: userId)),
        converter: (store) => store.state.userImageEntityState.entities[userId]?.image,
        builder: (context,image) {
          if(image == null){
            return Container(
              color: const Color.fromRGBO(226, 226, 226, 1),
            );
          }
          return Image.memory(image);
        }
      )
    );
  }
}

