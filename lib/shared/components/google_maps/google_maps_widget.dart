// ignore_for_file: must_be_immutable

import 'package:find_my_ca/shared/components/google_maps/google_maps_presenter.dart';
import 'package:find_my_ca/shared/components/google_maps/google_maps_view.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsWidget extends StatefulWidget {
  late GoogleMapsRoutePresenter _presenter;
  final LatLng _latLng;

  GoogleMapsWidget(this._latLng, {super.key}) {
    _presenter = GoogleMapsRoutePresenter();
  }

  @override
  State createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMapsWidget>
    implements GoogleMapsView {
  LatLng _initLatLng = const LatLng(0, 0);
  final GlobalKey _globalKey = GlobalKey();
  bool _isMapLoaded = false;

  @override
  void initState() {
    super.initState();
    widget._presenter.googleMapsRouteView = this;
    widget._presenter.onLoadRoute(widget._latLng);
  }

  @override
  void showRoute(LatLng latLng) {
    setState(() {
      _initLatLng = latLng;
      _isMapLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _globalKey,
      child: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            onCameraMove: _onCameraMove,
            markers: {
              Marker(
                markerId: const MarkerId("DEFAULT_ID"),
                position: _initLatLng,
              )
            },
            initialCameraPosition:
                CameraPosition(target: _initLatLng, zoom: 12.5),
            onMapCreated: (GoogleMapController controller) async {
              widget._presenter
                  .onMapCreated(controller, _globalKey, widget._latLng);
            },
          ),
          Visibility(
            visible: !_isMapLoaded,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }

  void _onCameraMove(CameraPosition position) {}
}
