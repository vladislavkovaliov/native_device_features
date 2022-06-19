import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:native_device_features/helpers/db_helper.dart';
import 'package:native_device_features/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(
    String title,
    File image,
    PlaceLocation _pickedLocation,
  ) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      location: _pickedLocation,
      image: image,
    );

    _items.add(newPlace);

    notifyListeners();

    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': _pickedLocation.latitude,
      'loc_lng': _pickedLocation.longitude,
    });
  }

  Future<void> featchAndSetPlaces() async {
    final list = await DBHelper.getData('user_places');

    _items = [];

    if (list.isEmpty) {
      _items = [];
    } else {
      _items = list
          .map(
            (x) => Place(
              id: x['id'],
              title: x['title'],
              image: File(x['image']),
              location: PlaceLocation(
                latitude: x['loc_lat'],
                longitude: x['loc_lng'],
              ),
            ),
          )
          .toList();
    }

    notifyListeners();
  }

  Place findById(String id) {
    return _items.firstWhere((x) => x.id == id);
  }
}
