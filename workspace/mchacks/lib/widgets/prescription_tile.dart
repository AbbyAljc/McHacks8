import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PrescriptionTile extends StatelessWidget {
  final String title;
  final DateTime expiryDate;

  PrescriptionTile({
    this.expiryDate,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return ListTile(
      title: Text(title),
      subtitle: Text("Expiry Date: " + formatter.format(this.expiryDate)),
      onTap: () {},
    );
  }
}
