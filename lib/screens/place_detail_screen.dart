import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/cupertino.dart';
import 'package:native_device_features/helpers/location_helper.dart';
import 'package:native_device_features/providers/great_places.dart';
import 'package:provider/provider.dart';

class PlaceDetailScreen extends StatelessWidget {
  static String routeName = 'place-detail-screen';

  const PlaceDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments;
    final place = Provider.of<GreatPlaces>(context, listen: false)
        .findById(id.toString());

    print(place);
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Place Details'),
      ),
      child: Image.network(
        LocationHelper.generateLocationPreviewImage(
          place.location!.latitude,
          place.location!.longitude,
        ),
        fit: BoxFit.cover,
        width: double.infinity,
      ),
    );
  }
}
