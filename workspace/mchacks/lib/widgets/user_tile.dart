import 'package:flutter/material.dart';
import 'package:mchacks/provider/users.dart';
import 'package:provider/provider.dart';

class UserTile extends StatefulWidget {
  final String userId;

  UserTile({this.userId});

  @override
  _UserTileState createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  @override
  Widget build(BuildContext context) {
    final userData =
        Provider.of<Users>(context, listen: false);
    final loadedUser = userData.findById(this.widget.userId);
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(loadedUser.photoUrl)),
      title: Text(loadedUser.name),
      subtitle: Text(
        "${loadedUser.type[0].toUpperCase()}${loadedUser.type.substring(1)} - ${loadedUser.institution[0].toUpperCase()}${loadedUser.institution.substring(1)}",
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.delete,
          color: Colors.red[700],
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Caution '),
                content: Text('Are you sure you want to remove ${loadedUser.name} from your Authorized Data Access list?'),
                actions: <Widget>[
                  new TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('No'),
                  ),
                  TextButton(
                    onPressed: () {
                      userData.removeAccess(loadedUser.id);
                      Navigator.of(context).pop();
                    },
                    child: Text('Yes'),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
