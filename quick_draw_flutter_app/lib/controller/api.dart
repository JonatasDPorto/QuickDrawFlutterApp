import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:quick_draw_flutter_app/model/classificacao_model.dart';

Future<List<Classificacao>> classificar(File imageFile, String filename) async {
  print('Enviando imagem...');
  var stream = http.ByteStream(imageFile.openRead());
  stream.cast();
  var length = await imageFile.length();
  var uri = Uri.parse('http://192.168.0.118:5000/classificar');
  var request = http.MultipartRequest("POST", uri);
  var multipartFile =
      http.MultipartFile('file', stream, length, filename: filename);

  request.files.add(multipartFile);
  var response = await request.send();
  var result = await response.stream.bytesToString();

  final Map<String, dynamic> responseJson =
      json.decode(result.toString()) as Map<String, dynamic>;

  return [
    Classificacao.fromList(
        'CNN', List<double>.from(responseJson['cnn'].map((e) => e.toDouble()))),
    Classificacao.fromList(
        'RNN', List<double>.from(responseJson['rnn'].map((e) => e.toDouble()))),
  ];
}
