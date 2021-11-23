import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

Future<String> classificarCNN(File imageFile, String filename) async {
  var stream = http.ByteStream(imageFile.openRead());
  stream.cast();
  var length = await imageFile.length();

  //this ip is my network's IPv4 ( I connected both my laptop and mobile
  //to this WiFi while establishing the connection)

  var uri = Uri.parse('http://192.168.0.118:5000/classificar');
  var request = http.MultipartRequest("POST", uri);
  var multipartFile =
      http.MultipartFile('file', stream, length, filename: filename);

  request.files.add(multipartFile);
  var response = await request.send();
  var result = await response.stream.bytesToString();

  final Map<String, dynamic> responseJson =
      json.decode(result.toString()) as Map<String, dynamic>;

  return responseJson["msg"];
}
