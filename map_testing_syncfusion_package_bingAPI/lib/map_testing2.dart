import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:http/http.dart' as http;
class MapTesting2 extends StatefulWidget {
  const MapTesting2({Key? key}) : super(key: key);

  @override
  State<MapTesting2> createState() => _MapTesting2State();
}

class _MapTesting2State extends State<MapTesting2> {
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
       maxZoomLevel: 20,
     );
   }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getBingUrlTemplate(
            'http://dev.virtualearth.net/REST/V1/Imagery/Metadata/RoadOnDemand?output=json&include=ImageryProviders&key=BING_API_KEY'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SfMaps(
              layers: [
                MapTileLayer(
                  initialFocalLatLng: const MapLatLng(20.5937, 78.9629),
                  zoomPanBehavior: _zoomPanBehavior,
                  initialZoomLevel: 14,
                  urlTemplate: snapshot.data!,
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
  
}
