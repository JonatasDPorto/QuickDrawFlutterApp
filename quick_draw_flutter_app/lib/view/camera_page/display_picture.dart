import 'dart:io';

import 'package:image/image.dart' as img;
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/material.dart';
import 'package:quick_draw_flutter_app/controller/api.dart';

class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  late File file;
  late String label;

  @override
  void initState() {
    super.initState();
    label = '???';
    file = File(widget.imagePath);
    print(file.path);
    cropImage();
  }

  void cropImage() {
    ImageCropper.cropImage(
      sourcePath: widget.imagePath,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      aspectRatioPresets: [CropAspectRatioPreset.square],
    ).then((value) {
      if (value == null) {
        Navigator.of(context).pop();
      }
      setState(() {
        file = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.file(file),
          (label != '???')
              ? Text(
                  'Isso é um desenho de: $label',
                  style: const TextStyle(fontSize: 20),
                )
              : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('     Voltar     '),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20)),
                onPressed: () {
                  if (label != '???') return;
                  var fileName = file.path.split('/').last;
                  classificarCNN(file, fileName).then((value) {
                    setState(() {
                      label = value;
                    });
                  });
                },
                child: const Text('Classificar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
