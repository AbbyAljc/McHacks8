import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mchacks/screens/prescription_detail_screen.dart';

class PrescriptionTile extends StatelessWidget {
  final String id;
  final String title;
  final DateTime expiryDate;

  PrescriptionTile({
    this.id,
    this.expiryDate,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return ListTile(
      title: Text(title),
      subtitle: Text("Expiry Date: " + formatter.format(this.expiryDate)),
      onTap: () {
        Navigator.of(context)
            .pushNamed(PrescriptionDetailScreen.routeName, arguments: this.id);
      },
    );
  }
}
