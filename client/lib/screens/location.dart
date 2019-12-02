//import 'dart:async';
//
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:dogwalker2/resources/global.dart';
//import 'package:dogwalker2/screens/components/address_component_factory.dart';
//import 'package:dogwalker2/screens/components/app_bar_factory.dart';
//import 'package:dogwalker2/screens/components/button_factory.dart';
//import 'package:dogwalker2/screens/components/text_factory.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:search_map_place/search_map_place.dart';
//
//class LocationPage extends StatefulWidget {
//  @override
//  _LocationPageState createState() => _LocationPageState();
//}
//
//class _LocationPageState extends State<LocationPage> {
//  Completer<GoogleMapController> _mapController = Completer();
//
//  final CameraPosition _initialCamera = CameraPosition(
//    target: LatLng(-20.3000, -40.2990),
//    zoom: 14.0000,
//  );
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child: Scaffold(
//        resizeToAvoidBottomPadding: false,
//        appBar: AppBarFactory.generate(context, "Direccion"),
//        body: Stack(
//          children: <Widget>[
//            GoogleMap(
//              mapType: MapType.normal,
//              initialCameraPosition: _initialCamera,
//              onMapCreated: (GoogleMapController controller) {
//                _mapController.complete(controller);
//              },
//            ),
//            Positioned(
//              top: 60,
//              left: MediaQuery.of(context).size.width * 0.05,
//              // width: MediaQuery.of(context).size.width * 0.9,
//              child: SearchMapPlaceWidget(
//                apiKey: Global.GOOGLE_MAPS_API_KEY,
//                location: _initialCamera.target,
//                radius: 30000,
//                onSelected: (place) async {
//                  final geolocation = await place.geolocation;
//
//                  final GoogleMapController controller = await _mapController.future;
//
//                  controller.animateCamera(CameraUpdate.newLatLng(geolocation.coordinates));
//                  controller.animateCamera(CameraUpdate.newLatLngBounds(geolocation.bounds, 0));
//                },
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}
