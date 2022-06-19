import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:native_device_features/helpers/location_helper.dart';

//

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImage;

  Future<void> _getCurrentUserLocation() async {
    final loc = await Location();

    try {
      final locationData = await Location().getLocation();
      final previewImage = LocationHelper.generateLocationPreviewImage(
        locationData.latitude!,
        locationData.longitude!,
      );

      setState(() {
        _previewImage = previewImage;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          decoration: BoxDecoration(
            // TODO: replace Colors to raw, avoid using material
            border: Border.all(
              width: 1.0,
              color: Colors.grey,
            ),
          ),
          width: double.infinity,
          alignment: Alignment.center,
          child: _previewImage == null
              ? const Text(
                  'No location chosen.',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImage.toString(),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: CupertinoButton.filled(
                onPressed: _getCurrentUserLocation,
                padding: EdgeInsets.zero,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      CupertinoIcons.location,
                      size: 25,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text('Current location'),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 8.0,
            ),
            Expanded(
              child: CupertinoButton.filled(
                onPressed: () {},
                padding: EdgeInsets.zero,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      CupertinoIcons.map,
                      size: 25,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text('Select on map'),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
