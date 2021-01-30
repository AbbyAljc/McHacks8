import 'package:mchacks/provider/prescription.dart';

List<Prescription> prescriptions = [
  Prescription(
    authoriztionId: '1',
    description: 'Ritalin for 3 doses of 200mg',
    expiry: DateTime.utc(2021, 02, 12),
    id: '1',
    name: 'Ritalin',
  ),
  Prescription(
    authoriztionId: '1',
    description: 'Xanax for 7 doses of 25mg to be taken in 6 hour intervals twice a day',
    expiry: DateTime.utc(2021, 02, 18),
    id: '2',
    name: 'Xanax',
  ),
  Prescription(
    authoriztionId: '2',
    description: 'Concerta for 4 doses of 25mg to be taken twice a day',
    expiry: DateTime.utc(2020, 12, 18),
    id: '3',
    name: 'Concerta',
  ),
];
