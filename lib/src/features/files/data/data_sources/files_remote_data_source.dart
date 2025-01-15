import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as h;
import 'package:http_parser/http_parser.dart';
import 'package:program_language_project/src/core/helpers/storage_helper.dart';

import '../../../../core/constants/env.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/helpers/http_helper.dart';
import '../../../../core/helpers/multipart_http_helper.dart';

abstract class FilesRemoteDataSource {
  Future<void> uploadImage(File image, String filename);

  Future<void> deleteImage();
}

class FilesRemoteDataSourceImpl implements FilesRemoteDataSource {
  final HttpHelper http;
  final StorageHelper storage;
  final MultipartHttpHelper multipartHttp;

  FilesRemoteDataSourceImpl({
    required this.http,
    required this.storage,
    required this.multipartHttp,
  });

  @override
  Future<void> uploadImage(File image, String filename) async {
    await http.handleApiCall(() async => await multipartHttp.postFile(
          "/profile/uploadImage",
          file: image,
          fileField: "image",
        ));
  }

  @override
  Future<void> deleteImage() async =>
      await http.handleApiCall(() async => await http.delete("/profile/image"));

  // @override
  // Future<void> uploadImage(File image, String filename) async {
  //   final uri = Uri.parse("http://${Env.host}/api/profile/uploadImage");
  //   final request = h.MultipartRequest('POST', uri)
  //     ..files.add(await h.MultipartFile.fromPath('image', image.path))
  //     ..headers["Accept"] = "application/json"
  //     ..headers["Content-Type"] = "multipart/form-data"
  //     ..headers["Authorization"] = "Bearer $token";
  //
  //   try {
  //     final response = await request.send();
  //     if (response.statusCode == 200) {
  //       print('Upload successful!');
  //     } else {
  //       print(response.statusCode);
  //       print(response.stream.toString());
  //       print('Failed to upload image');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }

  String get token {
    return storage.getString(accessTokenKey) ?? "";
  }
}
