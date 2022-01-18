import 'package:flutter/material.dart';
import 'package:restaurant_apps_local/data/api/api_service.dart';
import 'package:restaurant_apps_local/data/models/restaurant_item.dart';
import 'package:restaurant_apps_local/data/models/result_state.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }

  late RestaurantItem _restaurantItem;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantItem get result => _restaurantItem;

  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService.getListRestaurant();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantItem = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}