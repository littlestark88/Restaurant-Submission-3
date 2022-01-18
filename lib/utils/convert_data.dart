import 'package:restaurant_apps_local/data/models/detail_restaurant_item.dart';

import '../data/models/restaurant_item.dart';

Restaurant toMapRestaurantDetailToRestaurant(
    RestaurantDetail restaurantDetail) {
  return Restaurant(
      id: restaurantDetail.id,
      name: restaurantDetail.name,
      description: restaurantDetail.description,
      pictureId: restaurantDetail.pictureId,
      city: restaurantDetail.city,
      rating: restaurantDetail.rating
  );
}