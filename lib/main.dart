import 'package:flutter/cupertino.dart';
import 'package:native_device_features/providers/great_places.dart';
import 'package:native_device_features/screens/add_place_screen.dart';
import 'package:native_device_features/screens/places_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: CupertinoApp(
        title: 'Flutter Demo',
        theme: getCupertinoThemeData(),
        home: const PlaceListScreen(),
        routes: {
          PlaceListScreen.routeName: (ctx) => const PlaceListScreen(),
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
        },
      ),
    );
  }

  CupertinoThemeData getCupertinoThemeData() {
    return const CupertinoThemeData(
      textTheme: CupertinoTextThemeData(
        navLargeTitleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
    );
  }
}
