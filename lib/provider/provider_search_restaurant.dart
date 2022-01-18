import 'package:flutter/material.dart';
import 'package:restaurant_apps_local/data/api/api_service.dart';
import 'package:restaurant_apps_local/data/models/restaurant_item.dart';
import 'package:restaurant_apps_local/data/models/result_state.dart';

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  late String query;

  SearchRestaurantProvider.search({
    required this.apiService,
    required this.query,
  }) {
    fetchSearchRestaurant(query);
  }

  late SearchRestaurantItem _searchRestaurantItem;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  SearchRestaurantItem get result => _searchRestaurantItem;

  ResultState get state => _state;

  Future<dynamic> fetchSearchRestaurant(String query) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final searchRestaurant = await apiService.getSearchRestaurant(query);

      if (searchRestaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _searchRestaurantItem = searchRestaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}