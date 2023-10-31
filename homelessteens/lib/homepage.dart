// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:homelessteens/main.dart';
// import 'package:homelessteens/util.dart';
// // import 'package:location/location.dart';

// class Homepage extends StatefulWidget {
//   const Homepage({ Key? key}) : super(key: key);


//   @override
//   _HomepageState createState() => _HomepageState();
// }

// class _HomepageState extends State<Homepage> {
//   late GoogleMapController _controller;
//   final LatLng _initialCameraPosition = const LatLng(37.7749, -122.4194); // San Francisco, CA
//   // late LocationData _currentPosition;
//   // Location location = Location();
//   // bool permissionGranted = true;
//   String? _currentAddress;
//   Position? _currentPosition;

//   @override
//   void initState() {
//     super.initState();
//     // fetchLocation();
//     print("hello11");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: GoogleMap(
//           initialCameraPosition: CameraPosition(
//             // target: _initialCameraPosition,
//             target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
//             zoom: 12.0,
//           ),
//           onMapCreated: (controller) {
//             setState(() {
//               _controller = controller;
//             });
//           },
//         )
//       ),
//     );
//   } 

//   /*fetchLocation() async {
//     bool _serviceEnabled;
//     PermissionStatus _permissionGranted;
    

//     _serviceEnabled = await location.serviceEnabled();
//     print('hello');
//     if (!_serviceEnabled) {
//       print('he11o');
//       _serviceEnabled = await location.requestService();
//       if (!_serviceEnabled) {
//         print('hEllo');
//         return;
//       }
//     }
    
//     _permissionGranted = await location.hasPermission();
//     print("hello3");
//     if (_permissionGranted == PermissionStatus.denied) {
//       print("hello4");
//       _permissionGranted = await location.requestPermission();
//       print("hello5");
//       if (_permissionGranted != PermissionStatus.values) {
//         return;
//       }
//     }
//     print("hello2e1434214");
//     // _currentPosition = await location.getLocation();
//     print("hellofeet");
//     location.onLocationChanged.listen((LocationData locationData) {
      
//       setState(() {
//         _currentPosition = locationData;
//         print("boohoo");
//         // getAddress(_currentPosition.latitude, _currentPosition.longitude)
//         //     .then((value) {
//         //   setState(() {
//         //     _address = "${value.first.addressLine}";
//         //   });
//         // });
//       });
//     });
    
//   }*/
//   Future<bool> _handleLocationPermission() async {
//     bool serviceEnabled;
//     LocationPermission permission;
    
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text('Location services are disabled. Please enable the services')));
//       return false;
//     }
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {   
//         ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Location permissions are denied')));
//         return false;
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text('Location permissions are permanently denied, we cannot request permissions.')));
//       return false;
//     }
//     return true;
//   }
//   Future<void> _getCurrentPosition() async {
//     final hasPermission = await _handleLocationPermission();
//     if (!hasPermission) return;
//     await Geolocator.getCurrentPosition(
//             desiredAccuracy: LocationAccuracy.high)
//         .then((Position position) {
//       setState(() => _currentPosition = position);
//     }).catchError((e) {
//       debugPrint(e);
//     });
//   }
// // Future<List<Address>> getAddress(double lat, double lang) async {
// //     final coordinates = new Coordinates(lat, lang);
// //     List<Address> address =
// //         await Geocoder.local.findAddressesFromCoordinates(coordinates);
// //     return address;
// //   }
// }

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

enum Markerstate {home, foodbank, shelter}

class _HomePageState extends State<HomePage> {
  String? _currentAddress;
  Position? _currentPosition;
  final LatLng _initialCameraPosition = const LatLng(37.7749, -122.4194); // San Francisco, CA
  late GoogleMapController _controller;

  Set<Marker> markers = {};

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }
  Marker _addSafeSpaceMarker(String name, LatLng location, Markerstate d) {
    BitmapDescriptor icon = BitmapDescriptor.defaultMarker;
    if (d == Markerstate.foodbank) icon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
    else if (d== Markerstate.home) icon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
    else if (d== Markerstate.shelter) icon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow);

    Marker marker = Marker(markerId: MarkerId(name), icon: icon);

    setState(() {
      markers.add(marker);
    });

    return marker;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(//Center(
          // child: Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
            children: [
                _currentPosition != null ? GoogleMap(
                  initialCameraPosition: CameraPosition(
                    // target: _initialCameraPosition,
                    target: LatLng(_currentPosition?.latitude ?? _initialCameraPosition.latitude, _currentPosition?.longitude ?? _initialCameraPosition.longitude),
                    zoom: 5.0,
                  ),
                  onMapCreated: (controller) {
                    setState(() {
                      _controller = controller;
                    });
                  },
                  markers: markers,
                  onLongPress: (presslocation) {
                    
                  },
                ) : Center(child: const Text("Loading...")),
                Column(children: [
                Text('LAT: ${_currentPosition?.latitude ?? ""}'),
                Text('LNG: ${_currentPosition?.longitude ?? ""}'),
                Text('ADDRESS: ${_currentAddress ?? ""}'),
                const SizedBox(height: 32),
                ElevatedButton(
                onPressed: _getCurrentPosition,
                child: const Text("Get Current Location"),
                ),
                ],),
              ]
        )
      ),
    );
  }
}
