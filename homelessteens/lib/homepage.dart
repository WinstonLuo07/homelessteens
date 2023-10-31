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

import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'main.dart';

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

  late LatLng mousepos = _initialCameraPosition;

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
  Marker _addSafeSpaceMarker(String id, LatLng location, Markerstate d) {
    BitmapDescriptor icon = BitmapDescriptor.defaultMarker;
    if (d == Markerstate.foodbank) icon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
    else if (d== Markerstate.home) icon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
    else if (d== Markerstate.shelter) icon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow);

    Marker marker = Marker(markerId: MarkerId(id), icon: icon, position: location);

    setState(() {
      markers.add(marker);
    });

    return marker;
  }
  /// Callback when mouse clicked on `Listener` wrapped widget.
  Future<void> _onPointerDown(PointerDownEvent event) async {
    // Check if right mouse button clicked
    if ((event.kind == PointerDeviceKind.touch) &&
        event.buttons == kPrimaryButton) {
      final overlay =
          Overlay.of(context).context.findRenderObject() as RenderBox;
      
      final menuItem = await showMenu<int>(
          context: context,
          items: [
            PopupMenuItem(child: Text('Add Food bank marker'), value: 1),
            PopupMenuItem(child: Text('Add home marker'), value: 2),
            PopupMenuItem(child: Text('Add Shelter marker'), value: 3),
          ],
          useRootNavigator: true,
          elevation: 8,
          position: RelativeRect.fromSize(
              event.position & Size(48.0, 48.0), overlay.size));
      // Check if menu item clicked
      switch (menuItem) {
        case 1:
          // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          //   content: Text('Copy clicked'),
          //   behavior: SnackBarBehavior.floating,
          // ));
          setState(() {
          _addSafeSpaceMarker(mousepos.toString(), mousepos, Markerstate.foodbank);
          });
          break;
        case 2:
          // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          //     content: Text('Cut clicked'),
          //     behavior: SnackBarBehavior.floating));
          setState(() {
          _addSafeSpaceMarker(mousepos.toString(), mousepos, Markerstate.home);
          });
          break;
        case 3:
          setState(() {
          _addSafeSpaceMarker(mousepos.toString(), mousepos, Markerstate.shelter);
          });
          
          break;
        default:
      }

      }
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
      backgroundColor: theme.backgroundColor,
        body: SafeArea(
          child: Stack(
              children: [
                  _currentPosition != null ?  
                    Listener(
                      onPointerDown:  _onPointerDown,
                      child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        // target: _initialCameraPosition,
                        target: LatLng(_currentPosition?.latitude ?? _initialCameraPosition.latitude, _currentPosition?.longitude ?? _initialCameraPosition.longitude),
                        zoom: 14.0,
                      ),
                      onMapCreated: (controller) {
                        setState(() {
                          _controller = controller;
                        });
                      },
                      markers: markers,
                      onTap: (presslocation) {
                        if (presslocation.latitude == 0 && presslocation.longitude == 0) return;
                        setState(() {
                          mousepos = presslocation;
                        });
                      },
                    )) : Center(child: const Text("Loading...")),
                    Column(children: [
                    Text('LAT: ${_currentPosition?.latitude ?? ""}'),
                    Text('LNG: ${_currentPosition?.longitude ?? ""}'),
                    Text('ADDRESS: ${_currentAddress ?? ""}'),
                    const SizedBox(height: 32),
                    ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: theme.primaryColor),
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
