import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_apps_local/data/models/result_state.dart';
import 'package:restaurant_apps_local/provider/provider_database.dart';
import 'package:restaurant_apps_local/widget/custom_widget.dart';

import '../widget/restaurant_card_widget.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

Widget favoriteRestaurantList(BuildContext context) {
  return Consumer<ProviderDatabase>(builder: (context, state, _) {
    if (state.state == ResultState.HasData) {
      var restaurant = state.favorite;
      return ListView.builder(
          shrinkWrap: true,
          itemCount: restaurant.length,
          itemBuilder: (context, index) {
            var restaurants = restaurant[index];
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: RestaurantCardList(restaurant: restaurants),
            );
          });
    } else {
      return iconAndTextResponse(
          'assets/kosong.json', 'Favorite tidak di Temukan');
    }
  });
}
