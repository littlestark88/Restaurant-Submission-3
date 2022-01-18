import 'package:flutter/material.dart';
import 'package:restaurant_apps_local/data/models/restaurant_item.dart';
import 'package:restaurant_apps_local/theme.dart';

import '../page/detail_page.dart';

class RestaurantCardList extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantCardList({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailPage(restaurant: restaurant)),
        );
      },
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: SizedBox(
              width: 130,
              height: 110,
              child: Stack(
                children: [
                  Image.network(
                    'https://restaurant-api.dicoding.dev/images/large/' +
                        restaurant.pictureId!,
                    width: 130,
                    height: 110,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name!,
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                  ),
                  maxLines: 1,
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  restaurant.city!,
                  style: greyTextStyle,
                  maxLines: 1,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  restaurant.rating!.toString(),
                  style: greyTextStyle.copyWith(fontSize: 16),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
