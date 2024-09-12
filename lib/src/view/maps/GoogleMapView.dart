import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vgo_flutter_app/src/view/common/common_tool_bar_back.dart';

import '../../constants/color_view_constants.dart';

class GoogleMapView extends StatefulWidget {
  @override
  GoogleMapState createState() => GoogleMapState();
}

class GoogleMapState extends State<GoogleMapView> {
  static final LatLng _kMapCenter =
      LatLng(19.018255973653343, 72.84793849278007);

  static final CameraPosition _kInitialPosition =
      CameraPosition(target: _kMapCenter, zoom: 11.0, tilt: 0, bearing: 0);

  late GoogleMapController _controller;

  Future<void> onMapCreated(GoogleMapController controller) async {
    _controller = controller;
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
    _controller.setMapStyle(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorViewConstants.colorLightWhite,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: ColorViewConstants.colorBlueSecondaryText,
      ),
      body: Column(
        children: [
          toolBarTransferBackWidget(context, 'Track Delivery', false,
              completion: (value) {}),
          Expanded(
              child: GoogleMap(
            initialCameraPosition: _kInitialPosition,
                onMapCreated: onMapCreated,
                mapType: MapType.normal,myLocationEnabled: true,
          ))
        ],
      ),
    );
  }
}
