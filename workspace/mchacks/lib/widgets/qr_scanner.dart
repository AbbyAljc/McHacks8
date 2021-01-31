import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mchacks/provider/auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class QRScanButton extends StatelessWidget {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<Auth>(context);

    return FloatingActionButton(
      child: Icon(
        Icons.qr_code,
      ),
      onPressed: () => _scan(authData.userId),
    );
  }

  Future _scan(String userId) async {
    await Permission.camera.request();
    String barcode = await scanner.scan();
    if (barcode == null) {
      print('Nothing returned');
    } else {
      updatingCurrentSession(barcode, userId);
    }
  }

  Future<void> updatingCurrentSession(String sessionId, String userId) async {
    CollectionReference session = firestore.collection('sessions');
    print("USERID: $userId");
    session.doc(sessionId).update({
      'uid': userId,
    }).then((value) => print("success"));
  }
}
