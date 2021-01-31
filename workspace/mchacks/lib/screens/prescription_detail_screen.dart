import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mchacks/provider/prescriptions.dart';
import 'package:mchacks/widgets/direction_widget.dart';

import 'package:provider/provider.dart';

class PrescriptionDetailScreen extends StatelessWidget {
  static const routeName = '/detail';

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = new DateFormat('yyyy-MM-dd');
    final prescriptionId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct = Provider.of<Prescriptions>(
      context,
      listen: false,
    ).findById(prescriptionId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.name),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Number of refills: ${loadedProduct.refills}', style: _style(),),
            SizedBox(height: 10,),
            Text('Expiry Date: ${formatter.format(loadedProduct.expiry)}', style: _style(),),
            SizedBox(height: 10,),
            Text("Directions: ", style: _style(),),
            SizedBox(height: 10,),
            Container(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: loadedProduct.directions.length,
                itemBuilder: (ctx, index) =>
                    DirectionTile(content: loadedProduct.directions[index]),
              ),
            ),
            SizedBox(height: 10,),
            Text("Description: ${loadedProduct.description}", style: _style(),)
          ],
        ),
      ),
    );
  }
  

  TextStyle _style(){
    return TextStyle(
      fontSize: 18,
      height: 1.5
    );
  }
}
