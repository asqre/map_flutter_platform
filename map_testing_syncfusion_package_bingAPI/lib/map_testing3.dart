import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class MapTesting3 extends StatefulWidget {
  const MapTesting3({Key? key}) : super(key: key);

  @override
  State<MapTesting3> createState() => _MapTesting3State();
}

class _MapTesting3State extends State<MapTesting3> {
  late MapLatLng _markerPosition;
  late List<Model> _data;
  late List<Widget> _iconList;
  late _CustomZoomPanBehavior _mapZoomPanBehavior;
  late MapTileLayerController _controller;
  final double longitude = 75.8449651455931;
  final double latitude = 22.70495580458633;

  void updateMarkerChange(Offset position) {
    _markerPosition = _controller.pixelToLatLng(position);
    if (_controller.markersCount > 0) {
      _controller.clearMarkers();
    }
    _controller.insertMarker(0);
  }

  @override
  void initState() {
    _controller = MapTileLayerController();
    _data = [
      const Model(
          country: 'India',
          latitude: 22.642400735953625,
          longitude: 78.35253502627648),
      const Model(
        country: 'Turki',
        latitude: 39.29178469565057,
        longitude: 60.41142273657361,
      ),
      const Model(
          country: 'china',
          latitude: 36.54020979082134,
          longitude: 102.57303661737534),
    ];

    _iconList = [
      const Icon(Icons.add_location),
      const Icon(Icons.airplanemode_active),
      const Icon(Icons.account_balance)
    ];
    _mapZoomPanBehavior = _CustomZoomPanBehavior()
      ..onTap = updateMarkerChange
      ..zoomLevel = 14
      ..enableDoubleTapZooming = true
      ..enableMouseWheelZooming = true
      ..focalLatLng = const MapLatLng(22.70495580458633, 75.8449651455931)
      ..minZoomLevel = 4
      ..toolbarSettings = const MapToolbarSettings(
        position: MapToolbarPosition.bottomRight,
        itemHoverColor: Colors.greenAccent,
        direction: Axis.vertical,
        itemBackgroundColor: Colors.white,
        iconColor: Colors.blue,
      )
      ..maxZoomLevel = 20;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getBingUrlTemplate(
          'http://dev.virtualearth.net/REST/V1/Imagery/Metadata/RoadOnDemand?output=json&include=ImageryProviders&key=AnhLcaKdXHhMxvTrMgecxHIsEzi03xi_yyk1SLT5MWMhtF3WdnaNFl9uv2hjwiGL'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SfMaps(
            layers: [
              MapTileLayer(
                initialFocalLatLng: const MapLatLng(22.70495580458633, 75.8449651455931),
                zoomPanBehavior: _mapZoomPanBehavior,
                controller: _controller,
                initialZoomLevel: 14,
                urlTemplate: snapshot.data!,
                markerBuilder: (BuildContext context, int index) {
                  return MapMarker(
                    latitude: _markerPosition.latitude,
                    longitude: _markerPosition.longitude,
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 40,
                    ),
                  );
                },
              ),
            ],
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return  Center(
  //     child: SfMaps(
  //         layers: [
  //           MapTileLayer(
  //               urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
  //             initialMarkersCount: 3,
  //             markerBuilder: (BuildContext context, int index){
  //                 return MapMarker(
  //                   latitude: _data[index].latitude,
  //                   longitude: _data[index].longitude,
  //                   iconColor: Colors.blue,
  //                   child: _iconList[index],
  //
  //                 );
  //             }
  //           ),
  //
  //     ]),
  //   );
  // }
}

class Model {
  final String country;
  final double latitude;
  final double longitude;

  const Model(
      {required this.country, required this.latitude, required this.longitude});
}

class _CustomZoomPanBehavior extends MapZoomPanBehavior {
  late MapTypeCallback onTap;

  @override
  void handleEvent(PointerEvent event) {
    if (event is PointerUpEvent) {
      onTap(event.localPosition);
    }
    super.handleEvent(event);
  }
}

typedef MapTypeCallback = void Function(Offset position);
