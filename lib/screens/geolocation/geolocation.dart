import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:navigation_bar/screens/drawer/drawer.dart';
import 'package:overlay_support/overlay_support.dart';

class GeoLocation extends StatefulWidget {
  const GeoLocation({Key? key}) : super(key: key);

  @override
  State<GeoLocation> createState() => _GeoLocationState();
}

class _GeoLocationState extends State<GeoLocation> {
  //Internet Connectivity
  @override
  void initState() {
    super.initState();
    InternetConnectionChecker().onStatusChange.listen((status) {
      final connected = status == InternetConnectionStatus.connected;
      showSimpleNotification(
          Text(
            connected ? "CONNECTED TO INTERNET!" : "NO INTERNET!",
            textAlign: TextAlign.center,
          ),
          background: connected ? Colors.green : Colors.red);
    });
  }

  //Logic of GeoLocation
  Position? _currentLocation;
  late bool servicePermission = false;
  late LocationPermission permission;

  String _currentAddress = "";
  Future<Position> _getCurrentLocation() async {
    //Check Permission to Access Location Service
    servicePermission = await Geolocator.isLocationServiceEnabled();
    if (!servicePermission) {
      print("Service Disabled");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition();
  }

  //Let's Geocode the coordinates and convert them into address
  _getAddressFromCoordinates() async {
    try {
      List<Placemark> placesMarks = await placemarkFromCoordinates(
          _currentLocation!.latitude, _currentLocation!.longitude);
      Placemark place = placesMarks[0];
      setState(() {
        _currentAddress = "${place.locality}, ${place.country}";
      });
    } catch (ex) {
      print(ex);
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("Geo Location"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Location Coordinates:",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
                "Latitude: ${_currentLocation?.latitude} ;  Longitude: ${_currentLocation?.longitude}"),
            const SizedBox(height: 30),
            const Text(
              "Location Address:",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text("${_currentAddress}"),
            const SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () async {
                //Get Current Location
                _currentLocation = await _getCurrentLocation();
                await _getAddressFromCoordinates();
                print("${_currentLocation}");
                print("${_currentAddress}");
              },
              child: const Text("Get Location"),
            ),
          ],
        ),
      ),
    );
  }
}
