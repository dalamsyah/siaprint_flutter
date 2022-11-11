import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siapprint/config/constant.dart';
import 'package:siapprint/model/basket_model.dart';
import 'package:siapprint/model/inks_model.dart';
import 'package:siapprint/model/user_model.dart';

class UploadService {

  bool is_loading = false;

  Future<String> uploadFile(List<File> files) async {

    is_loading = true;

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    UserModel userModel = UserModel.fromJson(jsonDecode(localStorage.getString('user')!));

    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(Constant.apiuploadfile));
    for(var i = 0; i < files.length; i++){
      // request.files.add(await http.MultipartFile.fromPath('sendimage', path));
      request.files.add(http.MultipartFile(
          'sendimage$i', File(files[i].path).readAsBytes().asStream(), File(files[i].path).lengthSync(),
      filename: basename(files[i].path.split("/").last)) );
    }

    Map<String, String> map = {
      'apitoken': Constant.apitoken,
      'userid': userModel.id!
    };

    request.fields.addAll(map);

    // request.headers.addAll({'Authorization': 'Bearer 123424324234'});

    http.StreamedResponse response = await request.send();
    var responseBytes = await response.stream.toBytes();
    var responseString = utf8.decode(responseBytes);

    return responseString;
  }

  Future<dynamic> uploadPhotos(List<String> paths) async {
    List<MultipartFile> files = [];
    for(var path in paths) {
      files.add(await MultipartFile.fromFile(path));
    }

    var formData = FormData.fromMap({
      'files': files
    });

    var response = await Dio().post('http://10.0.0.103:5000/profile/upload-mutiple', data: formData);
    print('\n\n');
    print('RESPONSE WITH DIO');
    print(response.data);
    print('\n\n');
    return response.data;
  }

}