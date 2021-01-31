import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mchacks/provider/prescriptions.dart';
import 'package:mchacks/screens/auth_screen.dart';
import 'package:mchacks/screens/authorized_data_handlers.dart';
import 'package:mchacks/screens/history_screen.dart';
import 'package:mchacks/screens/prescription_detail_screen.dart';
import 'package:mchacks/screens/splash_screen.dart';
import 'package:provider/provider.dart';

import './provider/auth.dart';
import 'provider/prescription.dart';
import 'provider/users.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(PocketPrescription());
}

class PocketPrescription extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container();
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return MainApp();
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return SplashScreen();
        });
  }
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Prescriptions>(
            update: (context, auth, previousPrescriptions) => Prescriptions(
              auth.token,
              previousPrescriptions == null
                  ? []
                  : previousPrescriptions.prescriptions,
              auth.userId,
            ),
          ),
          ChangeNotifierProxyProvider<Auth, Users>(
            update: (context, auth, previousUsers) => Users(
              auth.token,
              previousUsers == null
                  ? []
                  : previousUsers.users,
              auth.userId,
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
            home: auth.isAuth
                ? HistoryScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, authResultSnapshot) =>
                        authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? SplashScreen()
                            : AuthScreen()),
            routes: {
              HistoryScreen.routeName: (ctx) => HistoryScreen(),
              PrescriptionDetailScreen.routeName: (ctx) =>
                  PrescriptionDetailScreen(),
              AuthorizedDataHandlers.routeName: (ctx) => AuthorizedDataHandlers(),
            },
          ),
        ));
  }
}
