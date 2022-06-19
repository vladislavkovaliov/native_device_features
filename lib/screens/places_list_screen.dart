import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:native_device_features/providers/great_places.dart';
import 'package:native_device_features/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

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
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder(
            future: Provider.of<GreatPlaces>(
              context,
              listen: false,
            ).featchAndSetPlaces(),
            builder: (ctx, snapshot) => Consumer<GreatPlaces>(
              builder: (ctx, greatPlaces, _) {
                print(greatPlaces.items);
                if (greatPlaces.items.isEmpty) {
                  return const Center(
                    child: Text('Got no places yet, start adding some.'),
                  );
                }

                return CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, idx) {
                          return Row(children: [
                            CircleAvatar(
                              backgroundImage:
                                  FileImage(greatPlaces.items[idx].image),
                            ),
                            const SizedBox(width: 10.0),
                            Text(greatPlaces.items[idx].title),
                          ]);
                        },
                        childCount: greatPlaces.items.length,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
