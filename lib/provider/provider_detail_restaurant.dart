import 'package:flutter/material.dart';
import 'package:restaurant_apps_local/data/api/api_service.dart';
import 'package:restaurant_apps_local/data/models/detail_restaurant_item.dart';
import 'package:restaurant_apps_local/data/models/result_state.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  late String id;

  DetailRestaurantProvider.detail({
    required this.apiService,
    required this.id
  }){
    _fetchDetailRestaurant(id);
  }

  late DetailRestaurantItem _detailRestaurantItem;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  DetailRestaurantItem get detailRestaurantItem => _detailRestaurantItem;

  ResultState get state => _state;

  Future<dynamic> _fetchDetailRestaurant(String id) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final detailRestaurant = await apiService.getDetailRestaurant(id);

      if(detailRestaurant.error) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'No Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _detailRestaurantItem = detailRestaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error: $e';
    }
  }
}