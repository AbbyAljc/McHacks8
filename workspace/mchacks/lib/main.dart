import 'package:flutter/material.dart';
import 'package:mchacks/provider/prescriptions.dart';
import 'package:mchacks/screens/auth_screen.dart';
import 'package:mchacks/screens/history_screen.dart';
import 'package:mchacks/screens/qr_scanner_screen.dart';
import 'package:provider/provider.dart';

import './provider/auth.dart';
import 'provider/prescription.dart';

void main() => runApp(PocketPrescription());

class PocketPrescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Prescriptions>(
            update: (ctx, auth, previousPrescriptions) => Prescriptions(
              authToken: auth.token,
              userId: auth.userId,
              prescriptions: 
              // previousPrescriptions == null
                  // ?
                   [
                      Prescription(
                        authoriztionId: '1',
                        description: 'Ritalin for 3 doses of 200mg',
                        expiry: DateTime(2021, 02, 12),
                        id: '1',
                        name: 'Ritalin',
                      ),
                      Prescription(
                        authoriztionId: '1',
                        description:
                            'Xanax for 7 doses of 25mg to be taken in 6 hour intervals twice a day',
                        expiry: DateTime(2021, 02, 18),
                        id: '2',
                        name: 'Xanax',
                      ),
                      Prescription(
                        authoriztionId: '2',
                        description:
                            'Concerta for 4 doses of 25mg to be taken twice a day',
                        expiry: DateTime(2022, 12, 18),
                        id: '3',
                        name: 'Concerta',
                      )
                    ]
                  // : previousPrescriptions.prescriptions,
            ),
          )
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.green,
              accentColor: Colors.deepOrange,
              fontFamily: 'Lato',
            ),
            home: auth.isAuth ? QRScannerScreen() : AuthScreen(),
            routes: {
              HistoryScreen.routeName: (ctx) => HistoryScreen(),
              // ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
              // OrdersScreen.routeName: (ctx) => OrdersScreen(),
              // UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
              // EditProductScreen.routeName: (ctx) => EditProductScreen(),
            },
          ),
        ));
  }
}
