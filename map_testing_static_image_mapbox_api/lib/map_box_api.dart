import 'package:flutter/material.dart';
import 'package:mapbox_search/colors/color.dart';
import 'package:mapbox_search/mapbox_search.dart';

class API {
  static const String googleAPI = 'AIzaSyA9jVfg8BZ_8yn2sfadeGJQNuE06pz2v9I';
  static const String bingAPI =
      'AnhLcaKdXHhMxvTrMgecxHIsEzi03xi_yyk1SLT5MWMhtF3WdnaNFl9uv2hjwiGL';
  static const String mapBoxAPI =
      'sk.eyJ1IjoiYXNxcmUiLCJhIjoiY2xnYnNoMjRqMDZ4azNmbzB1Z2FrZmVlYSJ9.dvz8YhPzseqwyCjkEDd_LQ';
}

List<Location> locations = [
  Location(lat: location.latitude, lng: location.longitude),
  Location(lat: 37.77343, lng: -122.46589)
];

class location {
  static const double latitude = 22.76400317821805;
  static const double longitude =  75.89879074024837;
}

var reverseGeoCoding = ReverseGeoCoding(apiKey: API.mapBoxAPI, limit: 5);
Future<List<MapBoxPlace>?> getPlaces() => reverseGeoCoding.getAddress(
      Location(lat: location.latitude, lng: location.longitude),
    );
var myColor = Colors.redAccent;

StaticImage staticImage = StaticImage(apiKey: API.mapBoxAPI);

class MapBoxAPI extends StatefulWidget {
  MapBoxAPI({Key? key}) : super(key: key);

  @override
  State<MapBoxAPI> createState() => _MapBoxAPIState();
}

class _MapBoxAPIState extends State<MapBoxAPI> {

  String getStaticImageWithMarker(int contextHeight,int contextWidth) => staticImage.getStaticUrlWithMarker(
    center: locations[0],
    marker: MapBoxMarker(
        markerColor: const RgbColor(252, 3, 24), markerLetter: 's', markerSize: MarkerSize.LARGE),
    height: contextHeight,
    width: (contextWidth < 1280)?contextWidth : 1280,
    zoomLevel: 13,
    style: MapBoxStyle.Streets,
    render2x: true,
  );

  // String getStaticImageWithPolyline(int contextHeight,int contextWidth) => staticImage.getStaticUrlWithPolyline(
  //     point1: Location(lat: 37.77343, lng: -122.46589),
  //     point2: Location(lat: 37.75965, lng: -122.42816),
  //     marker1: MapBoxMarker(
  //         markerColor: const RgbColor(3, 90, 252),
  //         markerSize: MarkerSize.LARGE,
  //         markerLetter: 'p',
  //     ),
  //     marker2: MapBoxMarker(
  //         markerColor: const RgbColor(3, 252, 7),
  //         markerSize: MarkerSize.LARGE,
  //         markerLetter: 't'
  //     ),
  //     height: contextHeight,
  //     width: contextWidth,
  //     zoomLevel: 13,
  //     style: MapBoxStyle.Streets,
  //     // path: MapBoxPath(pathColor: const RgbColor(252, 3, 3), pathWidth: 5, pathPolyline: '', pathOpacity: 0.5)
  // );



  @override
  Widget build(BuildContext context) {
    int contextWidth = MediaQuery.of(context).size.width.toInt();
    int contextHeight = MediaQuery.of(context).size.height.toInt();

    return Center(
      child: Image.network(getStaticImageWithMarker(contextHeight, contextWidth)),
    );
  }
}
