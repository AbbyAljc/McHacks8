import 'package:flutter/material.dart';
import 'package:mchacks/provider/users.dart';
import 'package:mchacks/widgets/app_drawer.dart';
import 'package:mchacks/widgets/prescription_list.dart';
import 'package:mchacks/widgets/qr_scanner.dart';
import 'package:mchacks/widgets/user_list.dart';
import 'package:provider/provider.dart';

import 'splash_screen.dart';

class AuthorizedDataHandlers extends StatefulWidget {
  static const routeName = '/manage-access';
  @override
  _AuthorizedDataHandlersState createState() => _AuthorizedDataHandlersState();
}

class _AuthorizedDataHandlersState extends State<AuthorizedDataHandlers> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Users>(context).fetchAndSetUsers().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text('Authorized Data Access'),
      ),
      body: _isLoading ? SplashScreen() : UserList(),
      floatingActionButton: QRScanButton(),
    );
  }
}