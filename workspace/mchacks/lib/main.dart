import 'package:flutter/material.dart';
import 'package:mchacks/screens/auth_screen.dart';
import 'package:mchacks/screens/qr_scanner_screen.dart';
import 'package:provider/provider.dart';

import './provider/auth.dart';

void main() => runApp(PocketPrescription());

class PocketPrescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
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
                ? QRScannerScreen()
                : AuthScreen(),
            routes: {
              // CartScreen.routeName: (ctx) => CartScreen(),
              // ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
              // OrdersScreen.routeName: (ctx) => OrdersScreen(),
              // UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
              // EditProductScreen.routeName: (ctx) => EditProductScreen(),
            },
          ),
        ));
  }
}
