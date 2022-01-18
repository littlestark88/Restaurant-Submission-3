import 'package:restaurant_apps_local/data/models/detail_restaurant_item.dart';
import 'package:restaurant_apps_local/data/models/restaurant_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String _searchRestaurant = 'search?q=';
  static const String _detailRestaurant = 'detail/';

  Future<RestaurantItem> getListRestaurant() async {
    final response = await http.get(Uri.parse(_baseUrl + "list"));

    if (response.statusCode == 200) {
      return RestaurantItem.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top Headlines');
    }
  }

  Future<SearchRestaurantItem> getSearchRestaurant(String query) async {
    final response = await http.get(Uri.parse(_baseUrl + _searchRestaurant + query));
    if(response.statusCode == 200) {
      return SearchRestaurantItem.fromJson(json.decode(response.body));
    }else {
      throw Exception('Failed Load Restaurant');
    }
  }

  Future<DetailRestaurantItem> getDetailRestaurant(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + _detailRestaurant + id));
    if(response.statusCode == 200) {
      return DetailRestaurantItem.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to Load Restaurant');
    }
  }
}