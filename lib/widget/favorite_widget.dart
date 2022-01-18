// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:restaurant_apps_local/data/models/restaurant_item.dart';
// import 'package:restaurant_apps_local/provider/provider_database.dart';
//
// class FavoriteWidget extends StatelessWidget {
//   final Restaurant restaurant;
//   const FavoriteWidget({Key? key, required this.restaurant}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ProviderDatabase>(
//       builder: (context, provider, child) {
//         return FutureBuilder<bool>(
//           future: provider.isFavorite(restaurant.id!),
//           builder: (context, snapshot) {
//             var isFavorite = snapshot.data ?? false;
//             // return InkWell()
//           },
//         );
//       }
//     );
//   }
// }
