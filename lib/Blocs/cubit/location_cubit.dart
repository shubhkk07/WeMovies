import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart' as geo;

import 'package:location/location.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  final loc = Location.instance;

  void fetchLocation() async {
    final LocationData coordinates = await Location.instance.getLocation();

    final List<geo.Placemark> placemark = await geo.placemarkFromCoordinates(coordinates.latitude!, coordinates.longitude!);
    emit(LocationLoaded(locationDetails: placemark.first));
  }

  void checkPermission() async {
    PermissionStatus permissionStatus = await loc.hasPermission();
    if (permissionStatus == PermissionStatus.granted || permissionStatus == PermissionStatus.grantedLimited) {
      fetchLocation();
    } else if (permissionStatus == PermissionStatus.deniedForever) {
      emit(LocationFetchErrorState(error: "Please change the location permission settings"));
    } else {
      emit(LocationRequestState());
    }
  }

  void requestPermission() async {
    await loc.requestPermission();
    checkPermission();
  }
}
