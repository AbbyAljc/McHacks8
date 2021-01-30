import 'package:flutter/material.dart';
import 'package:mchacks/provider/prescription.dart';

class Prescriptions with ChangeNotifier{
  final String authToken;
  final String userId;
  List<Prescription> prescriptions;

  Prescriptions({this.authToken, this.prescriptions, this.userId});

  List<Prescription> get activePrescriptions {
    return this.prescriptions.where(
          (element) => element.expiry.isAfter(
            DateTime.now().subtract(
              Duration(days: 1),
            ),
          ),
        ).toList();
  }

  List<Prescription> get expiredPrescriptions {
    return this.prescriptions.where(
          (element) => element.expiry.isBefore(
            DateTime.now(),
          ),
        ).toList();
  }

  void addPrescription(Prescription prescription){
    this.prescriptions.add(prescription);
    notifyListeners();
  }
}
