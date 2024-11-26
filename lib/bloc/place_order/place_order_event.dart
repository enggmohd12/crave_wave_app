import 'package:crave_wave_app/typedef/user.dart';

abstract class PlaceOrderEvent {
  const PlaceOrderEvent();
}

class PlaceOrderOfUserEvent extends PlaceOrderEvent {
  final UserId userId;
  final String address;

  const PlaceOrderOfUserEvent({
    required this.userId,
    required this.address,
  });
}

class FetchOrderDetails extends PlaceOrderEvent {
  final UserId userId;
  const FetchOrderDetails({
    required this.userId,
  });
}
