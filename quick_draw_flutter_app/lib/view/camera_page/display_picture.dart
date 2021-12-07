import 'dart:io';

import 'package:image/image.dart' as img;
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/material.dart';
import 'package:quick_draw_flutter_app/controller/api.dart';
import 'package:quick_draw_flutter_app/model/classificacao_model.dart';
import 'package:quick_draw_flutter_app/view/list_classificacao/list_classificacao.dart';

class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  late File file;
  late List<Classificacao> classificacoes;
  late Size size;
  @override
  void initState() {
    super.initState();
    classificacoes = [];
    file = File(widget.imagePath);
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
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.file(file),
          (classificacoes.isNotEmpty)
              ? SizedBox(
                  width: size.width,
                  height: size.width,
                  child: ListClassificacao(classificacoes: classificacoes),
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
                  var fileName = file.path.split('/').last;
                  classificar(file, fileName).then((value) {
                    setState(() {
                      classificacoes = value;
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
