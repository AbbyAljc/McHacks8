import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mchacks/provider/prescription.dart';

class Prescriptions with ChangeNotifier {
  final String authToken;
  final String userId;
  List<Prescription> _prescriptions;

  Prescriptions(this.authToken, this._prescriptions, this.userId);

  List<Prescription> get prescriptions {
    return [..._prescriptions];
  }

  List<Prescription> get activePrescriptions {
    return this
        ._prescriptions
        .where(
          (element) => element.expiry.isAfter(
            DateTime.now().subtract(
              Duration(days: 1),
            ),
          ),
        )
        .toList();
  }

  List<Prescription> get expiredPrescriptions {
    return this
        .prescriptions
        .where(
          (element) => element.expiry.isBefore(
            DateTime.now().subtract(Duration(days: 1)),
          ),
        )
        .toList();
  }

  Prescription findById(String id) {
    return this.prescriptions.firstWhere((element) => element.id == id);
  }

  void addPrescription(Prescription prescription) {
    this.prescriptions.add(prescription);
    notifyListeners();
  }

  Future<void> fetchAndSetPrescriptions() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      print(this.userId);

      final List<Prescription> loadedPrescriptions = [];
      await firestore
          .collection("prescription")
          .where("uid", isEqualTo: this.userId)
          .get()
          .then(
            (value) => value.docs.forEach(
              (element) {
                final dataDict = element.data();
                loadedPrescriptions.add(Prescription(
                    authoriztionId: dataDict['doctor_id'],
                    description: dataDict['prescription_details'],
                    expiry: dataDict['expiry_date'].toDate(),
                    id: element.reference.id,
                    name: dataDict['medication'],
                    directions: dataDict['directions'],
                    refills: dataDict['num_refills']));
              },
            ),
          );
      _prescriptions = loadedPrescriptions;
      print('test');
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}
