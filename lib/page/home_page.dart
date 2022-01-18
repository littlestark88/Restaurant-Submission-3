import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_apps_local/data/models/result_state.dart';
import 'package:restaurant_apps_local/provider/provider_restaurant.dart';
import 'package:restaurant_apps_local/theme.dart';
import 'package:restaurant_apps_local/widget/custom_widget.dart';
import 'package:restaurant_apps_local/widget/platform_widget.dart';
import 'package:restaurant_apps_local/widget/restaurant_card_widget.dart';

import 'search_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Widget _buildList() {
    return Consumer<RestaurantProvider>(builder: (context, state, _) {
      if (state.state == ResultState.Loading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state.state == ResultState.HasData) {
        return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.result.restaurants[index];
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: RestaurantCardList(restaurant: restaurant),
              );
            });
      } else if (state.state == ResultState.NoData) {
        return iconAndTextResponse(
            'assets/kosong.json',
            'Data Kosong');
      } else if (state.state == ResultState.Error) {
        return iconAndTextResponse(
            'assets/errors.json',
            'Memuat Data Gagal');
      } else {
        return const Center(child: Text(''));
      }
    });
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text('Restaurant App'),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchRestaurantPage()));
                },
                icon: const Icon(CupertinoIcons.search))
          ],
        ),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (BuildContext context,
            ConnectivityResult connectivity, Widget child) {
          if (connectivity == ConnectivityResult.none) {
            return Container(
              color: Colors.white,
              child: Center(
                child: iconAndTextResponse(
                    'assets/wifi.json',
                    'Please check your internet connection'),
              ),
            );
          } else {
            return child;
          }
        },
        builder: (BuildContext context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size_24,
              ),
              Padding(
                padding: EdgeInsets.only(left: size_24),
                child: Text(
                  'Restaurant',
                  style: blackTextStyle.copyWith(
                    fontSize: size_24,
                  ),
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Padding(
                padding: EdgeInsets.only(left: size_24),
                child: Text(
                  'Recommendation restaurant for you!',
                  style: greyTextStyle.copyWith(
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: size_24),
                    child: _buildList()),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Restaurant App'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
