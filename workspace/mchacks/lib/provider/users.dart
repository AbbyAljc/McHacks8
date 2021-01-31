import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'user.dart';

class Users with ChangeNotifier {
  final String authToken;
  final String userId;
  List<User> _users;

  Users(this.authToken, this._users, this.userId);

  List<User> get users {
    return [..._users];
  }

  User findById(String id) {
    return this._users.firstWhere((element) => element.id == id);
  }

  Future<void> fetchAndSetUsers() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      print(this.userId);

      final List<User> loadedProducts = [];
      CollectionReference col = firestore.collection("sessions");
      Query query = col.where("status", isEqualTo: 'viewing');
      query = query.where("uid", isEqualTo: this.userId);

      Set loadedDoctorId = new Set();
      await query.get().then(
            (value) => value.docs.forEach(
              (element) {
                final dataDict = element.data();
                loadedDoctorId.add(dataDict['doctor_id']);
              },
            ),
          );
      List<User> loadedUsers = [];
      for (String doctor in loadedDoctorId) {
        await firestore.collection('users').doc(doctor).get().then((value) {
          final dataDict = value.data();
          loadedUsers.add(
            User(
              id: doctor,
              institution: dataDict['clinic'],
              name: "${dataDict['first_name']} ${dataDict['last_name']}",
              photoUrl: dataDict['icon'],
              type: dataDict['type'],
            ),
          );
        });
      }
      _users = loadedUsers;
      print('test');
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  void removeAccess(String doctorId) async {

  }
}
