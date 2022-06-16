import 'package:flutter/cupertino.dart';
import 'package:native_device_features/screens/add_place_screen.dart';

class PlaceListScreen extends StatelessWidget {
  static String routeName = 'place-list-screen';

  const PlaceListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('{TITLE}'),
        trailing: CupertinoButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
          },
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.add),
        ),
      ),
      child: const Center(
        child: Text("place list"),
      ),
    );
  }
}
