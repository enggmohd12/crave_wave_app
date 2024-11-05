import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crave_wave_app/bloc/restaurant/restaurant_event.dart';
import 'package:crave_wave_app/bloc/restaurant/restaurant_state.dart';
import 'package:crave_wave_app/components/firebase_collection_name.dart';
import 'package:crave_wave_app/model/user_restaurant/user_restaurant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  RestaurantBloc()
      : super(
          const RestaurantInitialize(
            isLoading: false,
          ),
        ) {
    on<GetRestaurant>(
      (event, emit) async {
        emit(const RestaurantInitialize(isLoading: true));

        try {
          final sub = await FirebaseFirestore.instance
              .collection(
                FirebaseCollectionName.restaurant,
              )
              .get();
          if (sub.docs.isNotEmpty) {
            final docs = sub.docs;
            final restaurant = docs.map(
              (doc) => UserRestaurant(
                json: doc.data(),
                restaurantId: doc.id,
              ),
            );

            emit(RestaurantData(
              userRestaurant: restaurant,
              isLoading: false,
            ));
          } else {
            emit(
              const RestaurantNoData(isLoading: false),
            );
          }
        } catch (_) {
          emit(
            const RestaurantNoData(
                isLoading: false, error: 'Something went wrong'),
          );
        }
      },
    );
  }
}
