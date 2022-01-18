import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_apps_local/data/api/api_service.dart';
import 'package:restaurant_apps_local/data/db/database_helper.dart';
import 'package:restaurant_apps_local/page/splash_page.dart';
import 'package:restaurant_apps_local/provider/provider_database.dart';
import 'package:restaurant_apps_local/provider/provider_restaurant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
          ChangeNotifierProvider<RestaurantProvider>(
              create: (_) => 
                  RestaurantProvider(apiService: ApiService()),
          ),
        ChangeNotifierProvider<ProviderDatabase>(
          create: (_) =>
              ProviderDatabase(databaseHelper: DatabaseHelper()),
        ),
      ],
      child: MaterialApp(
          title: 'Restaurant App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const SplashPage(),
          debugShowCheckedModeBanner: false),
    );
  }
}
