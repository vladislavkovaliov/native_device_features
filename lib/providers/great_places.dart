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
  ) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      location: null,
      image: image,
    );

    _items.add(newPlace);

    notifyListeners();

    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    });
  }

  Future<void> featchAndSetPlaces() async {
    final list = await DBHelper.getData('user_places');

    _items = list
        .map(
          (x) => Place(
            id: x['id'],
            title: x['title'],
            image: File(x['image']),
            location: null, // TODO: use PlaceLocation constructor
          ),
        )
        .toList();

    notifyListeners();
  }
}
