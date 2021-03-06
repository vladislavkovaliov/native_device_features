import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:native_device_features/models/place.dart';
import 'package:native_device_features/providers/great_places.dart';
import 'package:native_device_features/widgets/image_input.dart';
import 'package:native_device_features/widgets/location_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatelessWidget {
  static String routeName = 'add-place-screen';

  final _titleController = TextEditingController();

  File? _pickerImage;
  PlaceLocation? _pickedLocation;

  void _selectImage(File pickedImage) {
    _pickerImage = pickedImage;
  }

  void _savePlace(BuildContext context) {
    if (_titleController.text.isEmpty ||
        _pickerImage == null ||
        _pickedLocation == null) {
      return;
    }

    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickerImage!, _pickedLocation!);

    Navigator.of(context).pop();
  }

  void _selectPickedPlace(double lat, double long) {
    _pickedLocation = PlaceLocation(
      latitude: lat,
      longitude: long,
    );
  }

  AddPlaceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Add Place'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    CupertinoTextField(
                      controller: _titleController,
                      padding: const EdgeInsets.all(16.0),
                      placeholder: "Title",
                      placeholderStyle: const TextStyle(
                        // TODO: replace by raw color
                        color: Colors.black38,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              ImageInput(
                onSelectedImage: _selectImage,
              ),
              const SizedBox(
                height: 20.0,
              ),
              LocationInput(
                onPickedPlace: _selectPickedPlace,
              ),
              const SizedBox(
                height: 20.0,
              ),
              CupertinoButton.filled(
                onPressed: () => _savePlace(context),
                padding: EdgeInsets.zero,
                child: const Text('Add picture'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
