import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:provider/provider.dart';

import '../data/api/api_service.dart';
import '../data/models/result_state.dart';
import '../provider/provider_search_restaurant.dart';
import '../theme.dart';
import '../widget/custom_widget.dart';
import '../widget/restaurant_card_widget.dart';

class SearchRestaurantPage extends StatefulWidget {
  const SearchRestaurantPage({Key? key}) : super(key: key);

  @override
  _SearchRestaurantPageState createState() => _SearchRestaurantPageState();
}

class _SearchRestaurantPageState extends State<SearchRestaurantPage> {
  String valueSearch = '';
  final TextEditingController _edtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchRestaurantProvider>(
      create: (_) => SearchRestaurantProvider.search(
          apiService: ApiService(), query: valueSearch),
      child: Consumer<SearchRestaurantProvider>(builder: (context, state, _) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
              title: Row(
                children: const <Widget>[
                  Center(child: Text('Search Restaurant')),
                ],
              )),
          body: OfflineBuilder(
            connectivityBuilder: (BuildContext context,
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
            },
            builder: (BuildContext context) {
              return SafeArea(
                bottom: false,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: size_20),
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(0, 10),
                                  blurRadius: 50,
                                  color: Colors.blue.withOpacity(0.23),
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: _edtController,
                              decoration: InputDecoration(
                                hintText: "Search Restaurant",
                                hintStyle: TextStyle(
                                  color: Colors.blue.withOpacity(0.5),
                                ),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                prefixIcon: const Icon(CupertinoIcons.search),
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  valueSearch = value;
                                  state.fetchSearchRestaurant(valueSearch);
                                  _buildSearchRestaurant(context, state);
                                });
                                if (value != '') {
                                  state.apiService.getSearchRestaurant(value);
                                }
                              },
                              onSubmitted: (String value) {
                                setState(() {
                                  valueSearch = value;
                                  state.fetchSearchRestaurant(valueSearch);
                                  _buildSearchRestaurant(context, state);
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24),
                                child: _buildSearchRestaurant(context, state),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _edtController.dispose();
  }

  Widget _buildSearchRestaurant(
      BuildContext context, SearchRestaurantProvider state) {
    if (state.state == ResultState.Loading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state.state == ResultState.HasData) {
      var searchRestaurant = state.result.restaurants;
      return ListView.builder(
          shrinkWrap: true,
          itemCount: searchRestaurant.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: RestaurantCardList(restaurant: searchRestaurant[index]),
            );
          });
    } else if (state.state == ResultState.NoData) {
      return iconAndTextResponse('assets/kosong.json', 'Data Tidak Ditemukan');
    } else if (state.state == ResultState.Error) {
      return iconAndTextResponse('assets/search.json', 'Cari Restaurant');
    } else {
      return const Center(child: Text(''));
    }
  }
}
