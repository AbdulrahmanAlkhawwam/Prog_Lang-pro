import 'dart:io';

import '../../../../core/helpers/http_helper.dart';
import '../../../../core/helpers/multipart_http_helper.dart';

abstract class FilesRemoteDataSource {
  Future<void> uploadImage(File image, String filename);

  Future<void> deleteImage();
}

class FilesRemoteDataSourceImpl implements FilesRemoteDataSource {
  final HttpHelper http;
  final MultipartHttpHelper multipartHttp;

  FilesRemoteDataSourceImpl({
    required this.http,
    required this.multipartHttp,
  });

  @override
  Future<void> uploadImage(File image, String filename) async {
    final imageBytes = image.readAsBytesSync();
    return await http.handleApiCall(() async {
      final response = await multipartHttp.postFile(
        "/profile/uploadImage",
        file: imageBytes,
        fileField: "file",
        filename: filename,
      );
      // print("12345${response.request.toString()}");
      // print("12345${response.statusCode.toString()}");
      // print("12345${response.headers.toString()}");
      // print("12345${response.body.toString()}");
    });
  }

  @override
  Future<void> deleteImage() async =>
      await http.handleApiCall(() async => await http.delete("/profile/image"));
}
