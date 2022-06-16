import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:native_device_features/widgets/image_input.dart';

class AddPlaceScreen extends StatelessWidget {
  static String routeName = 'add-place-screen';

  final _titleController = TextEditingController();

  AddPlaceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('{TITLE}'),
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
                        color: Colors.black38,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const ImageInput(),
            ],
          ),
        ),
      ),
    );
  }
}
