import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class MapTesting1 extends StatefulWidget {
  const MapTesting1({Key? key}) : super(key: key);

  @override
  State<MapTesting1> createState() => _MapTesting1State();
}

class _MapTesting1State extends State<MapTesting1> {

  late MapZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    super.initState();
    _zoomPanBehavior = MapZoomPanBehavior(
      zoomLevel: 14,
      enableDoubleTapZooming: true,
      enableMouseWheelZooming: true,
      focalLatLng: const MapLatLng(22.70495580458633, 75.8449651455931),
      minZoomLevel: 4,
      maxZoomLevel: 19,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getBingUrlTemplate(
        'https://dev.virtualearth.net/REST/V1/Imagery/Metadata/AerialWithLabels?output=json&uriScheme=https&include=ImageryProviders&key=AnhLcaKdXHhMxvTrMgecxHIsEzi03xi_yyk1SLT5MWMhtF3WdnaNFl9uv2hjwiGL'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SfMaps(
              layers: [
                MapTileLayer(
                  urlTemplate: snapshot.data as String,
                  zoomPanBehavior: _zoomPanBehavior,
                  initialFocalLatLng: const MapLatLng(22.70495580458633, 75.8449651455931),

                ),

              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        }
    );
  }
}



// @override
// Widget build(BuildContext context) {
//   return Container(
//     height: MediaQuery.of(context).size.height,
//     width: MediaQuery.of(context).size.width,
//     child: const SfMaps(
//       layers: [
//         MapTileLayer(
//           urlTemplate: 'https://www.openstreetmap.org/#map=4/19.30/82.45',
//           initialZoomLevel: 2,
//           initialFocalLatLng: MapLatLng(28.644800, 77.216721),
//         ),
//       ],
//     ),
//   );
// }