import 'package:flutter/material.dart';
import 'package:mchacks/provider/users.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget {
  final String userId;

  UserTile({this.userId});

  @override
  Widget build(BuildContext context) {
    final loadedUser =
        Provider.of<Users>(context, listen: false).findById(this.userId);
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(loadedUser.photoUrl)),
      title: Text(loadedUser.name),
      subtitle: Text(
        "${loadedUser.type[0].toUpperCase()}${loadedUser.type.substring(1)} - ${loadedUser.institution[0].toUpperCase()}${loadedUser.institution.substring(1)}",
      ),
    );
  }
}
