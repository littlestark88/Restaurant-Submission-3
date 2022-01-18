import 'package:flutter/material.dart';
import 'package:restaurant_apps_local/data/db/database_helper.dart';
import 'package:restaurant_apps_local/data/models/restaurant_item.dart';
import 'package:restaurant_apps_local/data/models/result_state.dart';

class ProviderDatabase extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  ProviderDatabase({required this.databaseHelper});

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _favorite = [];
  List<Restaurant> get favorite => _favorite;

  void _getAllFavoriteRestaurant() async {
    _favorite = await databaseHelper.getAllRestaurant();
    if(_favorite.isNotEmpty) {
      _state = ResultState.HasData;
    } else {
      _state = ResultState.NoData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  void addFavoriteRestaurant(Restaurant restaurant) async {
    try {
      await databaseHelper.insertRestaurant(restaurant);
      _getAllFavoriteRestaurant();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  void deleteFavoriteRestaurant(String id) async {
    try {
      await databaseHelper.removeRestaurant(id);
      _getAllFavoriteRestaurant();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String id) async {
    final favoriteRestaurant =
        await databaseHelper.getFavoriteRestaurantById(id);
    return favoriteRestaurant.isNotEmpty;
  }
}
