import 'package:flutter/material.dart';
import 'package:mchacks/provider/prescription.dart';
import 'package:mchacks/provider/prescriptions.dart';
import 'package:mchacks/screens/splash_screen.dart';
import 'package:mchacks/widgets/app_drawer.dart';
import 'package:mchacks/widgets/horizontal_divider.dart';
import 'package:mchacks/widgets/prescription_list.dart';
import 'package:mchacks/widgets/prescription_tile.dart';
import 'package:mchacks/widgets/qr_scanner.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  static const String routeName = '/history';

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
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
      Provider.of<Prescriptions>(context).fetchAndSetPrescriptions().then((_) {
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
        title: const Text('Prescriptions'),
      ),
      body: _isLoading ? SplashScreen() : PrescriptionList(),
      floatingActionButton: QRScanButton(),
    );
  }
}
