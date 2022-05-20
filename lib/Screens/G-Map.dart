import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:playgroup/Utilities/Strings.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({Key? key}) : super(key: key);

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  CameraPosition _initialLocation = CameraPosition(target: LatLng(28.0, 77.0));

  GoogleMapController? mapController;

  Position? _currentPosition;

  String? _currentAddress;

  List<Marker> _markers = [];

  bool Confirmation = false;

  TextEditingController SearchController = TextEditingController();

  String? destinationCoordinatesString;

  double? destinationLongitude;

  double? destinationLatitude;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // Method for retrieving the current location
  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        _currentPosition = position;
        mapController!.animateCamera(
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
          _currentPosition!.latitude, _currentPosition!.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("marker:$_markers");
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: _initialLocation,
              myLocationEnabled: true,
              markers: _markers.toSet(),
              onTap: (LatLng point) {
                if (_markers.length >= 1) {
                  _markers.clear();
                }
                Confirmation = true;
                Strings.Latt = point.latitude;
                Strings.Long = point.longitude;
                setState(() {
                  _markers.add(Marker(
                    markerId: MarkerId(point.toString()),
                    position: point,
                    icon: BitmapDescriptor.defaultMarker,
                  ));
                });
              },
            ),
            SafeArea(
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: width * 0.95,
                      height: 35,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextField(
                        style: TextStyle(height: 1),
                        controller: SearchController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search",
                          contentPadding:
                              const EdgeInsets.only(left: 20, top: 3),
                          //prefixIcon: Icon(Icons.search),
                          suffixIcon: IconButton(
                              onPressed: () {
                                // _scaffoldKey.currentState?.openDrawer();
                                GetLocationResult();
                              },
                              icon: Icon(Icons.search)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Visibility(
            //   visible: Confirmation == null ? false : true,
            //   child: SafeArea(
            //     child: Align(
            //       alignment: Alignment.topCenter,
            //       child: Padding(
            //         padding:
            //             const EdgeInsets.only(top: 70, left: 20, bottom: 20),
            //         child: Container(
            //           height: width * 0.15,
            //           width: width * 0.9,
            //           decoration: BoxDecoration(
            //             color: Colors.white70,
            //             borderRadius: BorderRadius.all(
            //               Radius.circular(20.0),
            //             ),
            //           ),
            //           child: Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //               crossAxisAlignment: CrossAxisAlignment.center,
            //               children: [
            //                 Text("Confirm your location"),
            //                 ElevatedButton(
            //                   onPressed: () {
            //                     Navigator.pop(context);
            //                   },
            //                   child: Text(
            //                     "Continue",
            //                     style: TextStyle(color: Colors.black),
            //                   ),
            //                   style: ButtonStyle(
            //                       backgroundColor:
            //                           MaterialStateProperty.all<Color>(
            //                               Colors.white)),
            //                 )
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
        bottomSheet: _showBottomSheet(),
      ),
    );
  }

  Widget? _showBottomSheet() {
    var width = MediaQuery.of(context).size.width;
    if (Confirmation!) {
      return BottomSheet(
        onClosing: () {},
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(35.0),
              ),
              boxShadow: <BoxShadow>[
                new BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  blurRadius: 5.0,
                  offset: new Offset(0.0, 2.0),
                ),
              ],
            ),
            height: 100,
            width: double.infinity,
            // color: Colors.white,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Confirm your location"),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Continue",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white)),
                )
              ],
            ),
          );
        },
      );
    } else {
      return null;
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    final marker = Marker(
      markerId: MarkerId('place_name'),
      position: LatLng(9.669111, 80.014007),
      // icon: BitmapDescriptor.,
      infoWindow: InfoWindow(
        title: 'title',
        snippet: 'address',
      ),
    );
  }

  GetLocationResult() async {
    try {
      List<Location> destinationPlacemark =
          await locationFromAddress(SearchController.text);
      double destinationLatitude = destinationPlacemark[0].latitude;
      double destinationLongitude = destinationPlacemark[0].longitude;
      String destinationCoordinatesString =
          '($destinationLatitude, $destinationLongitude)';
      print("Address:$destinationPlacemark");
      print("Address2:$destinationCoordinatesString");

      Strings.Latt = destinationLatitude;
      Strings.Long = destinationLongitude;
      setState(() {
        _markers.clear();
        Confirmation = true;
        _markers.add(Marker(
          markerId: MarkerId(destinationCoordinatesString.toString()),
          position: LatLng(destinationLatitude, destinationLongitude),
          icon: BitmapDescriptor.defaultMarker,
        ));

        mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(destinationLatitude, destinationLongitude),
              zoom: 12.0,
            ),
          ),
        );
      });
    } catch (e) {
      print(e);
    }
  }
}
