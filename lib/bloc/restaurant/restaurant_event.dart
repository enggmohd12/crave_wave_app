
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class RestaurantEvent{
  const RestaurantEvent();
}

class GetRestaurant extends RestaurantEvent{
  const GetRestaurant();
}