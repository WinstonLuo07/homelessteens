import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:homelessteens/main.dart';
import 'package:homelessteens/util.dart';
import 'package:location/location.dart';

class Homepage extends StatefulWidget {
  const Homepage({ Key? key}) : super(key: key);


  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late GoogleMapController _controller;
  final LatLng _initialCameraPosition = const LatLng(37.7749, -122.4194); // San Francisco, CA
  late LocationData _currentPosition;
  Location location = Location();
  bool permissionGranted = true;

  @override
  void initState() {
    super.initState();
    fetchLocation();
    print("hello11");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: _initialCameraPosition,
            // target: LatLng(_currentPosition.latitude!, _currentPosition.longitude!),
            zoom: 12.0,
          ),
          onMapCreated: (controller) {
            setState(() {
              _controller = controller;
            });
          },
        )
      ),
    );
  } 

  fetchLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    

    _serviceEnabled = await location.serviceEnabled();
    print('hello');
    if (!_serviceEnabled) {
      print('he11o');
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        print('hEllo');
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    print("hello3");
    if (_permissionGranted == PermissionStatus.denied) {
      print("hello4");
      _permissionGranted = await location.requestPermission();
      print("hello5");
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    print (await location.getLocation());
    print("hello2e1434214");
    _currentPosition = await location.getLocation();
    print("hellofeet");
    location.onLocationChanged.listen((LocationData currentLocation) {
      
      // setState(() {
      //   _currentPosition = currentLocation;
      //   // getAddress(_currentPosition.latitude, _currentPosition.longitude)
      //   //     .then((value) {
      //   //   setState(() {
      //   //     _address = "${value.first.addressLine}";
      //   //   });
      //   // });
      // });
    });
    
  }
// Future<List<Address>> getAddress(double lat, double lang) async {
//     final coordinates = new Coordinates(lat, lang);
//     List<Address> address =
//         await Geocoder.local.findAddressesFromCoordinates(coordinates);
//     return address;
//   }
}

