import 'dart:typed_data';
import 'package:furniture_app/global.dart';
import 'package:http/http.dart' as http;

class ApiCustomer {
  Future<Uint8List> removeImageBackgroundApi(String imagePath) async {
    var requestApi = http.MultipartRequest(
      "POST",
      Uri.parse("https://api.remove.bg/v1.0/removebg"),
    );

    requestApi.files.add(
      await http.MultipartFile.fromPath("image_file", imagePath),
    );
    requestApi.headers.addAll({
      "X-API-KEY": apiKeyRemoveImageBackground,
    });
    final responceFromApi = await requestApi.send();
    if (responceFromApi.statusCode == 200) {
      http.Response getTransparentImageFromResponse =
          await http.Response.fromStream(responceFromApi);
      return getTransparentImageFromResponse.bodyBytes;
    } else {
      throw Exception(
          "Error Occured : " + responceFromApi.statusCode.toString());
    }
  }
}
