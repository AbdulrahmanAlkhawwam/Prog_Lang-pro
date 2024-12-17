import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';
import 'dart:math' as math;

import 'package:http/http.dart';

import '../constants/strings.dart';
import '../errors/exceptions.dart';
import './storage_helper.dart';

abstract class HttpHelper {
  Future get(
    String path, {
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
  });

  Future post(
    String path, {
    Map<String, String>? queryParameters,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  });

  Future put(
    String path, {
    Map<String, String>? queryParameters,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  });

  Future patch(
    String path, {
    Map<String, String>? queryParameters,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  });

  Future delete(
    String path, {
    Map<String, String>? queryParameters,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  });

  Future<T> handleApiCall<T>(Future<T> Function() call);

  Future<void> close();

  Uri makeUri(String path, {Map<String, String>? queryParameters});
}

enum _Verb { get, post, put, patch, delete }

class HttpHelperImpl extends HttpHelper {
  final String host;
  final String basePath;
  final Client client;
  final StorageHelper storage;

  HttpHelperImpl({
    required this.host,
    required this.basePath,
    required this.client,
    required this.storage,
  });

  @override
  Future get(
    String path, {
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
  }) =>
      _sendRequest(_Verb.get, path,
          queryParameters: queryParameters, headers: headers);

  @override
  Future post(
    String path, {
    Map<String, String>? queryParameters,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) =>
      _sendRequest(_Verb.post, path,
          queryParameters: queryParameters, body: body, headers: headers);

  @override
  Future put(
    String path, {
    Map<String, String>? queryParameters,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) =>
      _sendRequest(_Verb.put, path,
          queryParameters: queryParameters, body: body, headers: headers);

  @override
  Future patch(
    String path, {
    Map<String, String>? queryParameters,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) =>
      _sendRequest(_Verb.patch, path,
          queryParameters: queryParameters, body: body, headers: headers);

  @override
  Future delete(
    String path, {
    Map<String, String>? queryParameters,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) =>
      _sendRequest(_Verb.delete, path,
          queryParameters: queryParameters, body: body, headers: headers);

  @override
  Future<T> handleApiCall<T>(Future<T> Function() call) async {
    try {
      return await call();
    } on AuthorizationException catch (e) {
      if (e.retry) {
        return await call();
      } else {
        throw AuthorizationException("Not logged in", false);
      }
    } on ClientException catch (e) {
      throw ServerException(e.message);
    } on SocketException catch (e) {
      throw ServerException(e.message);
    } on ServerException {
      rethrow;
    } on FormatException catch (e) {
      throw ParsingException(e.toString());
    }
  }

  Future _sendRequest(
    _Verb verb,
    String path, {
    Map<String, String>? queryParameters,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    final uri = makeUri(path, queryParameters: queryParameters);
    final h = _makeHeaders(extraHeaders: headers);
    final b = body != null ? jsonEncode(body) : body;
    dev.log(uri.toString(), name: "HttpHelper.${verb.name}");
    dev.log(h.toString(), name: "HttpHelper.${verb.name}.headers");
    dev.log(body.toString(), name: "HttpHelper.${verb.name}.body");
    final Response response;
    response = await switch (verb) {
      _Verb.get => client.get(uri, headers: h),
      _Verb.post => client.post(uri, body: b, headers: h),
      _Verb.put => client.put(uri, body: b, headers: h),
      _Verb.patch => client.patch(uri, body: b, headers: h),
      _Verb.delete => client.delete(uri, body: b, headers: h)
    };
    dev.log(
      response.body.substring(0, math.min(response.body.length, 100)),
      name: "HttpHelper.${verb.name}.response",
    );
    if (response.statusCode == 401 && token.isNotEmpty) {
      throw AuthorizationException("Expired access token", true);
    } else if (response.statusCode ~/ 100 != 2) {
      throw ServerException(
        jsonDecode(response.body)["message"]?.toString() ??
            response.statusCode.toString(),
        statusCode: response.statusCode,
        body: response.body,
      );
    }
    try {
      return jsonDecode(response.body);
    } catch (e) {
      return response.body;
    }
  }

  Map<String, String> _makeHeaders({Map? extraHeaders}) => {
        // "Accept": "application/json",
        "Content-Type": "application/json",
        "Accept-Language": locale,
        if (token.isNotEmpty) "Authorization": "Bearer $token",
        ...?extraHeaders,
      };

  String get token {
    return storage.getString(accessTokenKey) ?? "";
  }

  String get locale {
    return storage.getString(localeKey) ?? "";
  }

  @override
  Uri makeUri(String path, {Map<String, String>? queryParameters}) =>
      Uri.http(host, [basePath, path].join(), queryParameters);

  @override
  Future<void> close() async {
    client.close();
  }
}
