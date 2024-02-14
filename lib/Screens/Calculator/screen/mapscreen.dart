import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math' show cos, sqrt, asin;
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'dart:async';
import '../../../constants.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'dart:math';

void main() {
  runApp(MapView());
}

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  CameraPosition _initialLocation = CameraPosition(target: LatLng(0.0, 0.0));
  late GoogleMapController mapController;
  Set<Polyline> _polylines = {};

  late Position _currentPosition;
  String _currentAddress = '';

  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();
  final dayController = TextEditingController();
  TextEditingController carTypeController = TextEditingController();
  TextEditingController tripController = TextEditingController();

  final startAddressFocusNode = FocusNode();
  final dayFocusNode = FocusNode();
  final destinationAddressFocusNode = FocusNode();
  late FocusNode carTypeFocusNode;
  late FocusNode tripFocusNode;

  String _startAddress = '';
  String _destinationAddress = '';
  String? _placeDistance;

  @override
  void dispose() {
    carTypeFocusNode.dispose();
    tripFocusNode.dispose();
    super.dispose();
  }

  Set<Marker> markers = {};

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<BitmapDescriptor> _createMarkerImageFromAsset(
    String assetName, {
    int width = 48,
    int height = 48,
  }) async {
    final ByteData byteData = await rootBundle.load(assetName);
    final Uint8List byteList = byteData.buffer.asUint8List();

    final Codec codec = await ui.instantiateImageCodec(byteList,
        targetWidth: width, targetHeight: height);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    final ui.Image image = frameInfo.image;

    final ByteData? pngBytes =
        await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List resizedBytes = Uint8List.view(pngBytes!.buffer);

    return BitmapDescriptor.fromBytes(resizedBytes);
  }

  Widget _textField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    required String hint,
    required double width,
    required Icon prefixIcon,
    Widget? suffixIcon,
    required Function(String) locationCallback,
  }) {
    return Container(
      width: width * 0.8,
      child: TextField(
        onChanged: (value) {
          locationCallback(value);
        },
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: kPrimaryColor,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: kPrimaryLightColor,
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.all(width * 0.04),
          hintText: hint,
        ),
      ),
    );
  }

  // Method for retrieving the current location
  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        _currentPosition = position;
        print('CURRENT POS: $_currentPosition');
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 18.0,
            ),
          ),
        );
      });
      await _getAddress();
    }).catchError((e) {
      print(e);
    });
  }

  // Method for retrieving the address
  _getAddress() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
        startAddressController.text = _currentAddress;
        _startAddress = _currentAddress;
      });
    } catch (e) {
      print(e);
    }
  }

  // Method for calculating the distance between two places
  Future<bool> _calculateDistance() async {
    try {
      // Retrieving placemarks from addresses
      List<Location> startPlacemark = await locationFromAddress(_startAddress);
      List<Location> destinationPlacemark =
          await locationFromAddress(_destinationAddress);

      // Use the retrieved coordinates of the current position,
      // instead of the address if the start position is user's
      // current position, as it results in better accuracy.
      double startLatitude = _startAddress == _currentAddress
          ? _currentPosition.latitude
          : startPlacemark[0].latitude;

      double startLongitude = _startAddress == _currentAddress
          ? _currentPosition.longitude
          : startPlacemark[0].longitude;

      double destinationLatitude = destinationPlacemark[0].latitude;
      double destinationLongitude = destinationPlacemark[0].longitude;

      String startCoordinatesString = '($startLatitude, $startLongitude)';
      String destinationCoordinatesString =
          '($destinationLatitude, $destinationLongitude)';

      // Start Location Marker
      Marker startMarker = Marker(
        markerId: MarkerId(startCoordinatesString),
        position: LatLng(startLatitude, startLongitude),
        infoWindow: InfoWindow(
          title: 'Start $startCoordinatesString',
          snippet: _startAddress,
        ),
        icon: await _createMarkerImageFromAsset('assets/images/cab_start.png',
            width: 200, height: 200),
      );

      // Destination Location Marker
      Marker destinationMarker = Marker(
        markerId: MarkerId(destinationCoordinatesString),
        position: LatLng(destinationLatitude, destinationLongitude),
        infoWindow: InfoWindow(
          title: 'Destination $destinationCoordinatesString',
          snippet: _destinationAddress,
        ),
        icon: await _createMarkerImageFromAsset('assets/images/red_end.png',
            width: 250, height: 250),
      );

      // Adding the markers to the list
      markers.add(startMarker);
      markers.add(destinationMarker);

      print(
        'START COORDINATES: ($startLatitude, $startLongitude)',
      );
      print(
        'DESTINATION COORDINATES: ($destinationLatitude, $destinationLongitude)',
      );

      Polyline polyline = Polyline(
        polylineId: PolylineId('route'),
        points: [
          LatLng(startLatitude, startLongitude),
          LatLng(destinationLatitude, destinationLongitude),
        ],
        color: Colors.red, // set the color of the polyline
        width: 3, // set the width of the polyline
      );

      // Set state to rebuild the UI with the polyline
      setState(() {
        _placeDistance = _coordinateDistance(
          startLatitude,
          startLongitude,
          destinationLatitude,
          destinationLongitude,
        ).toStringAsFixed(2);

        // Add polyline to map
        _polylines.add(polyline);
      });

      // Calculating to check that the position relative
      // to the frame, and pan & zoom the camera accordingly.
      double miny = (startLatitude <= destinationLatitude)
          ? startLatitude
          : destinationLatitude;
      double minx = (startLongitude <= destinationLongitude)
          ? startLongitude
          : destinationLongitude;
      double maxy = (startLatitude <= destinationLatitude)
          ? destinationLatitude
          : startLatitude;
      double maxx = (startLongitude <= destinationLongitude)
          ? destinationLongitude
          : startLongitude;

      double southWestLatitude = miny;
      double southWestLongitude = minx;

      double northEastLatitude = maxy;
      double northEastLongitude = maxx;

      // Accommodate the two locations within the
      // camera view of the map
      mapController.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            northeast: LatLng(northEastLatitude, northEastLongitude),
            southwest: LatLng(southWestLatitude, southWestLongitude),
          ),
          100.0,
        ),
      );

      // Calculating the distance between the start and the end positions
      // with a straight path, without considering any route
      double totalDistance = _coordinateDistance(
        startLatitude,
        startLongitude,
        destinationLatitude,
        destinationLongitude,
      );

      setState(() {
        _placeDistance = totalDistance.toStringAsFixed(2);
        print('DISTANCE: $_placeDistance km');
      });

      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  // Formula for calculating distance between two coordinates
  // https://stackoverflow.com/a/54138876/11910277
  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  double selectedCarValue = 0.0;
  double selectedTripValue = 0.0;
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    carTypeFocusNode = FocusNode();
    tripFocusNode = FocusNode();
  }

  final Map<String, double> carValues = {
    "Sedan": 12.0, // Example value for Sedan
    "SUV": 18.0, // Example value for SUV
    "Ertiga": 14.0 // Example value for Ertiga
  };
  final Map<String, double> tripValues = {
    "One Way Trip": 1.0,
    "Round Trip": 2.0, // Example value Trip
  };

// Create a variable to store the selected value

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenWidth,
      width: screenWidth,
      child: Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: <Widget>[
            // Map View
            GoogleMap(
              markers: Set<Marker>.from(markers),
              initialCameraPosition: _initialLocation,
              polylines: _polylines,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              mapType: MapType.normal,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
            ),
            // Show zoom buttons
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                    left: screenWidth * 0.01, top: screenWidth * 0.6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ClipOval(
                      child: Material(
                        color: Colors.blue.shade100, // button color
                        child: InkWell(
                          splashColor: Colors.blue, // inkwell color
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Icon(Icons.add),
                          ),
                          onTap: () {
                            mapController.animateCamera(
                              CameraUpdate.zoomIn(),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: screenWidth * 0.04),
                    ClipOval(
                      child: Material(
                        color: Colors.blue.shade100, // button color
                        child: InkWell(
                          splashColor: Colors.blue, // inkwell color
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Icon(Icons.remove),
                          ),
                          onTap: () {
                            mapController.animateCamera(
                              CameraUpdate.zoomOut(),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            // Show the place input fields & button for
            // showing the route
            SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: screenWidth * 0.02),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    width: screenWidth * 0.9,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: screenWidth * 0.02, bottom: screenWidth * 0.02),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Rent Calculator',
                            style: TextStyle(fontSize: screenWidth * 0.06),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.only(
                                left: screenWidth * 0.05,
                                right: screenWidth * 0.05,
                                top: screenWidth * 0.03),
                            child: _textField(
                              label: 'Start',
                              hint: 'Choose starting point',
                              prefixIcon:
                                  Icon(Icons.my_location, color: kPrimaryColor),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.location_searching,
                                ),
                                onPressed: () {
                                  startAddressController.text = _currentAddress;
                                  _startAddress = _currentAddress;
                                },
                              ),
                              controller: startAddressController,
                              focusNode: startAddressFocusNode,
                              width: screenWidth,
                              locationCallback: (String value) {
                                setState(() {
                                  _startAddress = value;
                                });
                              },
                            ),
                          ),
                          SizedBox(height: screenWidth * 0.04),
                          Padding(
                            padding: EdgeInsets.only(
                                left: screenWidth * 0.05,
                                right: screenWidth * 0.05),
                            child: _textField(
                              label: 'Destination',
                              hint: 'Choose destination',
                              prefixIcon:
                                  Icon(Icons.location_on, color: kPrimaryColor),
                              controller: destinationAddressController,
                              focusNode: destinationAddressFocusNode,
                              width: screenWidth,
                              locationCallback: (String value) {
                                setState(() {
                                  _destinationAddress = value;
                                });
                              },
                            ),
                          ),
                          SizedBox(height: screenWidth * 0.04),
                          Padding(
                            padding: EdgeInsets.only(
                                left: screenWidth * 0.05,
                                right: screenWidth * 0.05),
                            child: SimpleAutoCompleteTextField(
                              key: GlobalKey(),
                              controller: carTypeController,
                              focusNode: carTypeFocusNode,
                              suggestions: ["Sedan", "SUV", "Ertiga"],
                              textChanged: (text) {},
                              cursorColor: kPrimaryLightColor,
                              clearOnSubmit: false,
                              textSubmitted: (selectedCar) {
                                // Retrieve the associated value from the map
                                selectedCarValue = carValues[selectedCar] ??
                                    0.0; // Provide a default value if null

                                // Use the selected value in your calculations
                              },
                              decoration: InputDecoration(
                                labelText: 'Select Car',
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(width: 2.0),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 12.0),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                      color: kPrimaryLightColor,
                                      width: 2.0), // Focused border color
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: kPrimaryColor, width: 2),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                prefixIcon: Icon(Icons.car_rental,
                                    color: kPrimaryColor),
                              ),
                            ),
                          ),
                          SizedBox(height: screenWidth * 0.04),
                          Padding(
                            padding: EdgeInsets.only(
                                left: screenWidth * 0.05,
                                right: screenWidth * 0.05),
                            child: Row(
                              children: [
                                Expanded(
                                  child: _textField(
                                    label: 'Day',
                                    hint: 'Enter Days',
                                    width: screenWidth * 0.4,
                                    controller: dayController,
                                    focusNode: dayFocusNode,
                                    prefixIcon: Icon(Icons.access_time,
                                        color: kPrimaryColor),
                                    locationCallback: (String value) {
                                      // Callback function for day text field
                                    },
                                  ),
                                ),
                                SizedBox(
                                    width: screenWidth *
                                        0.04), // Add spacing between text fields
                                Expanded(
                                  child: SimpleAutoCompleteTextField(
                                    key: GlobalKey(),
                                    controller: tripController,
                                    focusNode: tripFocusNode,
                                    suggestions: ["One Way Trip", "Round Trip"],
                                    textChanged: (text) {},
                                    cursorColor: kPrimaryLightColor,
                                    clearOnSubmit: false,
                                    textSubmitted: (selectedTrip) {
                                      // Retrieve the associated value from the map
                                      selectedTripValue = tripValues[
                                              selectedTrip] ??
                                          0.0; // Provide a default value if null

                                      // Use the selected value in your calculations
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Trip Type',
                                      fillColor: Colors.white,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(width: 2.0),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 12.0),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                            color: kPrimaryLightColor,
                                            width: 2.0), // Focused border color
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: kPrimaryColor, width: 2),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      prefixIcon: Icon(Icons.repeat,
                                          color: kPrimaryColor),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: screenWidth * 0.04),
                          Visibility(
                            visible: _placeDistance == null ? false : true,
                            child: Text(
                              'MINIMUM RENT : ${(_placeDistance != null) ? (((selectedCarValue) * max(double.parse(_placeDistance!) * selectedTripValue * 1.3, 300 * double.parse(dayController.text))).toInt()) : 'N/A'} RS ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: screenWidth * 0.04),
                          Container(
                            height: screenWidth *
                                0.15, // Set the desired height for the button
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: screenWidth * 0.05,
                                  right: screenWidth *
                                      0.05), // Adjust padding as needed
                              child: ElevatedButton(
                                onPressed: (_startAddress != '' &&
                                        _destinationAddress != '' &&
                                        selectedTripValue != 0 &&
                                        selectedCarValue != 0 &&
                                        dayController.text.isNotEmpty)
                                    ? () async {
                                        startAddressFocusNode.unfocus();
                                        destinationAddressFocusNode.unfocus();
                                        setState(() {
                                          if (markers.isNotEmpty)
                                            markers.clear();
                                          _placeDistance = null;
                                        });

                                        _calculateDistance()
                                            .then((isCalculated) {
                                          if (isCalculated) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    'Distance Calculated Successfully'),
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    'Error Calculating Distance'),
                                              ),
                                            );
                                          }
                                        });
                                      }
                                    : null,
                                child: Text(
                                  'Calculate Now'.toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenWidth * 0.05,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: kPrimaryLightColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Show current location button
            SafeArea(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                  child: ClipOval(
                    child: Material(
                      color: Colors.orange.shade100, // button color
                      child: InkWell(
                        splashColor: Colors.orange, // inkwell color
                        child: SizedBox(
                          width: 56,
                          height: 56,
                          child: Icon(Icons.my_location),
                        ),
                        onTap: () {
                          mapController.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: LatLng(
                                  _currentPosition.latitude,
                                  _currentPosition.longitude,
                                ),
                                zoom: 18.0,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
