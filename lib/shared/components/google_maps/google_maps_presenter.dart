// ignore_for_file: unused_field

import 'dart:async';

import 'package:find_my_ca/shared/components/google_maps/google_maps_view.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsRoutePresenter {
  final Completer<GoogleMapController> _controller = Completer();
  GoogleMapsView? _view;
  LatLngBounds? _latLngBounds;

  GoogleMapController? _googleMapController;

  GoogleMapsRoutePresenter();

  set googleMapsRouteView(GoogleMapsView value) {
    _view = value;
  }

  void onMapCreated(
      GoogleMapController controller, GlobalKey key, LatLng latLng) async {
    _controller.complete(controller);
    _googleMapController = controller;
    await _moveCamera(500);
  }

  void onLoadRoute(LatLng latLng) async {
    // use this to reload the map
    //_view?.showRoute(_polylines!, _initLatLng!);
    _view?.showRoute(latLng);
    await _moveCamera(2000);
  }

  Future<void> _moveCamera(int delayInMilliseconds) async {
    await Future.delayed(
      Duration(milliseconds: delayInMilliseconds),
      () {
        if (_googleMapController != null && _latLngBounds != null) {
          _googleMapController!
              .moveCamera(CameraUpdate.newLatLngBounds(_latLngBounds!, 50));
        }
      },
    );
  }
}
