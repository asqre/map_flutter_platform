import 'package:flutter/material.dart';
import 'package:google_maps/google_maps.dart' hide Icon;
import 'dart:html';
import 'dart:ui' as ui;
class BugMap extends StatefulWidget  {
  const BugMap({Key? key}) : super(key: key);

  @override
  State<BugMap> createState() => _BugMapState();
}

class _BugMapState extends State<BugMap> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: getMap(),
    );
  }

  Widget getMap(){
    String htmlId ='7';
    //ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(htmlId, (int veiwId){

      final myLatlng =LatLng(22.684367662219938, 75.71381585359737);

      final mapOptions = MapOptions()
        ..zoom = 8
        ..center = LatLng(22.684367662219938, 75.71381585359737);

      final elem=DivElement()
          ..id=htmlId
          ..style.width='100%'
          ..style.height='100%'
          ..style.border='none';
      final map= new GMap(elem, mapOptions);
      Marker(MarkerOptions()
        ..position = myLatlng
          ..map= map
          ..title='Hello World!');
      return elem;
    });
    return HtmlElementView(viewType: htmlId);
  }
}
