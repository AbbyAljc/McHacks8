import 'package:flutter/material.dart';
import 'package:mchacks/provider/prescriptions.dart';
import 'package:provider/provider.dart';

import 'horizontal_divider.dart';
import 'prescription_tile.dart';

class PrescriptionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prescriptionsData = Provider.of<Prescriptions>(context);
    final activePrescriptions = prescriptionsData.activePrescriptions;
    final expiredPrescriptions = prescriptionsData.expiredPrescriptions;
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        HorizontalOrLine(height: 10, label: "Active"),
        Expanded(
          flex: 1,
          child: ListView.builder(
            itemCount: activePrescriptions.length,
            itemBuilder: (ctx, index) => PrescriptionTile(
              id: activePrescriptions[index].id,
              expiryDate: activePrescriptions[index].expiry,
              title: activePrescriptions[index].name,
            ),
          ),
        ),
        SizedBox(height:10),
        HorizontalOrLine(height: 10, label: 'Expired'),
        Expanded(
          flex: 2,
          child: ListView.builder(
            itemCount: expiredPrescriptions.length,
            itemBuilder: (ctx, index) => PrescriptionTile(
              id: expiredPrescriptions[index].id,
              expiryDate: expiredPrescriptions[index].expiry,
              title: expiredPrescriptions[index].name,
            ),
          ),
        ),
      ],
    );
  }
}
