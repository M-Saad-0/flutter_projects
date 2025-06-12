// import 'dart:async';

// import 'package:geolocator/geolocator.dart';

// class GeolocatorService {
//   GeolocatorService() {
//     _getPermissions();
//   }

//   Future<void> _getPermissions() async {
//     bool isEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!isEnabled) {
//       throw Exception("Location Permission is disabled");
//     }

//     LocationPermission locationPermission = await Geolocator.checkPermission();
//     if (locationPermission == LocationPermission.denied) {
//       locationPermission = await Geolocator.requestPermission();
//       if (locationPermission == LocationPermission.denied) {
//         throw Exception("This guy is being smartass!");
//       }
//     }
//     if (locationPermission == LocationPermission.deniedForever) {
//       throw Exception("This service is not for you!");
//     }
//   }

//   final LocationSettings _locationSettings = LocationSettings(
//     accuracy: LocationAccuracy.high,
//     distanceFilter: 100,
//   );

//   Stream<Position> positionStream() {
//     final Stream<Position> postion = Geolocator.getPositionStream(
//       locationSettings: _locationSettings,
//     );
//     return postion;
//   }
// }
