import 'package:flutter/material.dart';
import 'package:mchacks/provider/prescriptions.dart';
import 'package:mchacks/provider/users.dart';
import 'package:mchacks/widgets/user_tile.dart';
import 'package:provider/provider.dart';

import 'horizontal_divider.dart';
import 'prescription_tile.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final usersData = Provider.of<Users>(context);
    final authorizedUsers = usersData.users;
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        HorizontalOrLine(height: 10, label: "Active"),
        Expanded(
          flex: 1,
          child: ListView.builder(
            itemCount: authorizedUsers.length,
            itemBuilder: (ctx, index) => UserTile(
              userId: authorizedUsers[index].id,
            ),
          ),
        ),
      ],
    );
  }
}