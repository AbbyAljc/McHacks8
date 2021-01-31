import 'package:flutter/material.dart';
import 'package:mchacks/provider/prescription.dart';
import 'package:mchacks/screens/authorized_data_handlers.dart';
import 'package:mchacks/screens/history_screen.dart';
import 'package:provider/provider.dart';

import '../provider/auth.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Select Tab'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('Prescriptions'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(HistoryScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Manage Access'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(AuthorizedDataHandlers.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
