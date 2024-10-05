import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class LocationEvent{
  const LocationEvent();
}

class LocationInitializeEvent extends LocationEvent{
  const LocationInitializeEvent();
}

class LocationGetPermissionEvent extends LocationEvent{
  const LocationGetPermissionEvent();
}

class GetLocationEvent extends LocationEvent{
  const GetLocationEvent();
}