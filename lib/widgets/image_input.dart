import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({Key? key}) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> _takePicture() async {
    final pickedImage = await await ImagePicker().pickImage(
      // TODO: replace it to cemare when you use real devie
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    final imageFile = File(pickedImage!.path);

    _setStoredImage(imageFile);

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);

    final savedImage = await imageFile.copy('${appDir.path}/$fileName');
  }

  _setStoredImage(File imageFile) {
    setState(() {
      _storedImage = imageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            // TODO: replace Colors to raw, avoid using material
            border: Border.all(
              width: 1.0,
              color: Colors.grey,
            ),
          ),
          alignment: Alignment.center,
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text(
                  "No image taken",
                  textAlign: TextAlign.center,
                ),
        ),
        const SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: CupertinoButton.filled(
            onPressed: _takePicture,
            padding: EdgeInsets.zero,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  CupertinoIcons.camera,
                  size: 25,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text('Take picture'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
