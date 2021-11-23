import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:quick_draw_flutter_app/view/camera_page/camera_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();

  final firstCamera = cameras.first;
  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: TakePictureScreen(
        camera: firstCamera,
      ),
    ),
  );
}
