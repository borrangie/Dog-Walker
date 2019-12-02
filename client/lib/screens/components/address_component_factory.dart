import 'package:dogwalker2/screens/components/text_factory.dart';
import 'package:flutter/material.dart';

abstract class AddressFactory {
//  static GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: Global.GOOGLE_MAPS_API_KEY);

  static Container generateAddressTextField(context) {
    return Container(
      alignment: Alignment.center,
      child: RaisedButton(
        onPressed: () async {
//          Navigator.push(
//            context,
//            MaterialPageRoute(builder: (context) {
//              return LocationPage();
//            })
//          );
        },
        child: Text('Find address'),
      )
    );
  }

  static Container generateAddressContainer(context, locationController, departmentController, descriptionController, title) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          generateAddressTextField(context),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ),
          TextFactory.generateTextField(departmentController, "Apartamento"),
          SizedBox(
            height: 10,
          ),
          TextFactory.generateTextField(descriptionController, "Descripcion adicional"),
        ],
      ),
    );
  }
}
