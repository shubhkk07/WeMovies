part of 'location_cubit.dart';

@immutable
sealed class LocationState {}

final class LocationInitial extends LocationState {}

final class LocationRequestState extends LocationState {}

final class LocationLoading extends LocationState {}

final class LocationLoaded extends LocationState {
  final geo.Placemark locationDetails;

  LocationLoaded({required this.locationDetails});
}

final class LocationFetchErrorState extends LocationState {
  final String error;

  LocationFetchErrorState({required this.error});
}
