import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'options.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(FontAwesomeIcons.tools),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Options()));
            }),
        title: Text("Seguridad Turística"),
        actions: <Widget>[
          IconButton(
              icon: Icon(FontAwesomeIcons.search),
              onPressed: () {
                //
              }),
        ],
      ),
      body: Stack(
        children: <Widget>[
          _buildGoogleMap(context),
          _location(),
          _buildContainer(),
        ],
      ),
    );
  }

  Widget _location() {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
          icon: Icon(FontAwesomeIcons.locationArrow, color: Color(0xFF3863F3)),
          padding: EdgeInsets.fromLTRB(10, 40, 25, 10),
          onPressed: () {
            locateUser();
          }),
    );
  }

  Future<Position> locateUser() async {
    return Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((location) {
      if (location != null) {
        _gotoUser(location.latitude, location.longitude);
      }
      return location;
    });
  }

  Future<void> _gotoUser(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 19,
      tilt: 0.0,
      bearing: 0.0,
    )));
  }

  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 100.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://i0.wp.com/www.aiesec.org.ec/wp-content/uploads/2018/09/usfq.png?ssl=1",
                  -0.196929,
                  -78.436607,
                  "USFQ"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://www.pucevirtual.edu.ec/wp-content/uploads/2016/12/logonuevo.png",
                  -0.20896709262045476,
                  -78.49102905261708,
                  "PUCE"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://www.usek.cl/media/1367/logos-blanco-usek-2016.jpg",
                  -0.0896865815730905,
                  -78.48241985389308,
                  "SEK"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _boxes(String _image, double lat, double long, String universidad) {
    return GestureDetector(
      onTap: () {
        _gotoLocation(lat, long);
      },
      child: Container(
        child: new FittedBox(
          child: Material(
              color: Colors.white70,
              elevation: 14.0,
              borderRadius: BorderRadius.circular(24.0),
              shadowColor: Color(0x802196F3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 300,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(24.0),
                      child: Image(
                        fit: BoxFit.scaleDown,
                        image: NetworkImage(_image),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: myDetailsContainer1(universidad),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget myDetailsContainer1(String universidad) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 2.0, right: 15.0),
          child: Container(
              child: Text(
            universidad,
            style: TextStyle(
                color: Color(0xff0000ff),
                fontSize: 40.0,
                fontWeight: FontWeight.bold),
          )),
        ),
      ],
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        compassEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
            target: LatLng(-0.15566149999999998, -78.46381629999999), zoom: 12),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {puceMarker, usfqMarker, sekMarker},
      ),
    );
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 17,
      tilt: 0.0,
      bearing: 0.0,
    )));
  }
}

Marker puceMarker = Marker(
  markerId: MarkerId('puce'),
  position: LatLng(-0.20896709262045476, -78.49102905261708),
  infoWindow: InfoWindow(title: 'PUCE'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);

Marker usfqMarker = Marker(
  markerId: MarkerId('usfq'),
  position: LatLng(-0.196929, -78.436607),
  infoWindow: InfoWindow(title: 'USFQ'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueRed,
  ),
);
Marker sekMarker = Marker(
  markerId: MarkerId('sek'),
  position: LatLng(-0.0896865815730905, -78.48241985389308),
  infoWindow: InfoWindow(title: 'SEK'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueBlue,
  ),
);