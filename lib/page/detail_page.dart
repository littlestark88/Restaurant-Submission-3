import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_apps_local/data/api/api_service.dart';
import 'package:restaurant_apps_local/data/models/restaurant_item.dart';
import 'package:restaurant_apps_local/provider/provider_detail_restaurant.dart';
import 'package:restaurant_apps_local/utils/convert_data.dart';
import 'package:restaurant_apps_local/widget/custom_widget.dart';

import '../data/models/detail_restaurant_item.dart';
import '../data/models/result_state.dart';
import '../provider/provider_database.dart';
import '../theme.dart';
import '../widget/rating_widget.dart';

class DetailPage extends StatefulWidget {
  final Restaurant restaurant;

  const DetailPage({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailRestaurantProvider>(
      create: (_) => DetailRestaurantProvider.detail(
          apiService: ApiService(), id: widget.restaurant.id!),
      child: Consumer<DetailRestaurantProvider>(builder: (context, state, _) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: OfflineBuilder(connectivityBuilder: (BuildContext context,
              ConnectivityResult connectivity, Widget child) {
            if (connectivity == ConnectivityResult.none) {
              return Container(
                color: Colors.white,
                child: Center(
                  child: iconAndTextResponse(
                    'assets/wifi.json',
                    'Please check your internet connection',
                  ),
                ),
              );
            } else {
              return child;
            }
          }, builder: (BuildContext context) {
            return _detailRestaurantResult(context, state);
          }),
        );
      }),
    );
  }

  Widget _detailRestaurantResult(
      BuildContext context, DetailRestaurantProvider state) {
    if (state.state == ResultState.Loading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state.state == ResultState.HasData) {
      return _detailRestaurantView(
          state.detailRestaurantItem.restaurantDetail, context);
    } else if (state.state == ResultState.NoData) {
      return iconAndTextResponse('assets/kosong.json', 'Data Tidak Ditemukan');
    } else if (state.state == ResultState.Error) {
      return iconAndTextResponse('assets/search.json', 'Cari Restaurant');
    } else {
      return const Center(child: Text(''));
    }
  }
}

Widget _detailRestaurantView(
    RestaurantDetail detailRestaurant, BuildContext context) {
  return Scaffold(
    backgroundColor: whiteColor,
    body: SafeArea(
      bottom: false,
      child: Stack(
        children: [
          Image.network(
            'https://restaurant-api.dicoding.dev/images/large/' +
                detailRestaurant.pictureId!,
            width: MediaQuery.of(context).size.width,
            height: 350,
            fit: BoxFit.cover,
          ),
          ListView(
            children: [
              const SizedBox(
                height: 328,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  color: whiteColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size_24,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Expanded(
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                detailRestaurant.name!,
                                style: blackTextStyle.copyWith(
                                  fontSize: 22,
                                ),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                detailRestaurant.city!,
                                style: greyTextStyle.copyWith(fontSize: 16),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Row(
                                  children: [1, 2, 3, 4, 5].map((index) {
                                return Container(
                                  margin: const EdgeInsets.only(
                                    left: 2,
                                  ),
                                  child: RatingWidget(
                                      index: index,
                                      rating: detailRestaurant.rating!.toInt()),
                                );
                              }).toList()),
                            ],
                          ),
                          // ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: size_24),
                      child: Text(
                        'Menu',
                        style: blackTextStyle.copyWith(
                          fontSize: 22,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                      ),
                      child: Text(
                        'Food',
                        style: blackTextStyle.copyWith(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: _listFood(detailRestaurant.menus.foods),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                      ),
                      child: Text(
                        'Drink',
                        style: blackTextStyle.copyWith(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: _listDrink(detailRestaurant.menus.drinks),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                      ),
                      child: Text(
                        'Review Customer',
                        style: blackTextStyle.copyWith(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: _customerReview(detailRestaurant.customerReviews),
                    ),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size_24,
              vertical: 30,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    'assets/btn_back.png',
                    width: 40,
                  ),
                ),
                _favoriteButton(detailRestaurant.id!, detailRestaurant)
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _listFood(List<Foods> food) {
  return ListView.builder(
    padding: EdgeInsets.symmetric(horizontal: size_24),
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemBuilder: (context, index) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 5,
          ),
          contentTextGrey(food[index].name!),
        ],
      );
    },
    itemCount: food.length,
  );
}

Widget _listDrink(List<Drinks> drink) {
  return ListView.builder(
    padding: EdgeInsets.symmetric(horizontal: size_24),
    shrinkWrap: true,
    itemBuilder: (context, index) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 5,
          ),
          contentTextGrey(drink[index].name!),
        ],
      );
    },
    itemCount: drink.length,
  );
}

Widget _customerReview(List<CustomerReview> reviews) {
  return ListView.builder(
    padding: EdgeInsets.symmetric(horizontal: size_24),
    shrinkWrap: true,
    itemBuilder: (context, index) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          contentTextGrey(reviews[index].review!),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              contentTextGrey(reviews[index].name!),
              contentTextGrey(reviews[index].date!),
            ],
          ),
          const Divider(
            thickness: 2,
            height: 0,
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      );
    },
    itemCount: reviews.length,
  );
}

Widget _favoriteButton(String id, RestaurantDetail restaurantDetail) {
  return Consumer<ProviderDatabase>(
    builder: (context, state, child) {
      return FutureBuilder<bool>(
          future: state.isFavorite(id),
          builder: (context, snapshot) {
            var isFavorite = snapshot.data ?? false;
            return InkWell(
                child: isFavorite
                    ? IconButton(
                        icon: const Icon(Icons.favorite),
                        color: Theme.of(context).accentColor,
                        onPressed: () => state.deleteFavoriteRestaurant(id),
                      )
                    : IconButton(
                        icon: const Icon(Icons.favorite_outline),
                        color: Theme.of(context).accentColor,
                        onPressed: () => state.addFavoriteRestaurant(toMapRestaurantDetailToRestaurant(restaurantDetail)),
                      ));
          });
    },
  );
}
