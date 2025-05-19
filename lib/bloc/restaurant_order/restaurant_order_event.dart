abstract class RestaurantOrderEvent {}

class LoadRestaurantOrders extends RestaurantOrderEvent {
  final String restaurantId;
  LoadRestaurantOrders({
    required this.restaurantId,
  });
}
