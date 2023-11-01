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
                    // Text('LAT: ${_currentPosition?.latitude ?? ""}'),
                    // Text('LNG: ${_currentPosition?.longitude ?? ""}'),
                    // Text('ADDRESS: ${_currentAddress ?? ""}'),
                    const SizedBox(height: 32),
                    ],),
                    Align(
                      alignment: Alignment(-0.9, 0.89),
                      child: FloatingActionButton(
                      // style: ElevatedButton.styleFrom(backgroundColor: theme.primaryColor),
                      onPressed: _getCurrentPosition,
                      backgroundColor: _currentPosition == null ? Colors.red : Colors.blue,
                      child: Icon(Icons.pin_drop,)
                      ),
                    ),
                    
              ]
          )
        ),
      );
  }
}
