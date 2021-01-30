import 'package:flutter/material.dart';
import 'package:mchacks/provider/prescription.dart';
import 'package:mchacks/provider/prescriptions.dart';
import 'package:mchacks/widgets/app_drawer.dart';
import 'package:mchacks/widgets/horizontal_divider.dart';
import 'package:mchacks/widgets/prescription_tile.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatelessWidget {
  static const String routeName = '/history';
  @override
  Widget build(BuildContext context) {
    final prescriptionsData = Provider.of<Prescriptions>(context);
    final activePrescriptions = prescriptionsData.activePrescriptions;
    final expiredPrescriptions = prescriptionsData.expiredPrescriptions;
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text('Prescriptions'),
      ),
      body: Column(
        children: <Widget>[
          HorizontalOrLine(height: 10, label: "Active"),
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: activePrescriptions.length,
              itemBuilder: (ctx, index) => PrescriptionTile(
                expiryDate: activePrescriptions[index].expiry,
                title: activePrescriptions[index].name,
              ),
            ),
          ),
          HorizontalOrLine(height: 10, label: 'Expired'),
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: expiredPrescriptions.length,
              itemBuilder: (ctx, index) => PrescriptionTile(
                expiryDate: expiredPrescriptions[index].expiry,
                title: expiredPrescriptions[index].name,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          prescriptionsData.addPrescription(
            Prescription(
                authoriztionId: '1',
                description: 'test',
                expiry: DateTime(2020, 12, 18),
                id: '5',
                name: 'Pills'),
          );
        },
        label: Text('Add Prescription (Testing)'),
      ),
    );
  }
}
