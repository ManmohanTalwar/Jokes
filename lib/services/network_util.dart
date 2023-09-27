import 'dart:async';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:jokes/helper/app_prefs.dart';
import 'package:jokes/helper/config.dart';
import 'package:jokes/injection.dart';

import 'base_service.dart';

class NetworkUtil implements BaseServices {
  Map<String, String> headers = {
    'Accept': '*/*',
  };

  http.Client client = http.Client();

  Future<Response> _get(
    String url,
    Map<String, String>? headers,
  ) async {
    if (locator<AppPrefs>().token.getValue().isNotEmpty) {
      headers!['Authorization'] =
          'Bearer ${locator<AppPrefs>().token.getValue()}';
    }

    log('GET-URL:: $url');
    log('GET-HEADER:: $headers');
    return await client
        .get(
      Uri.parse(url),
      headers: headers,
    )
        .then((Response response) {
      return _handleResponse(response, url);
    });
  }

  Future<Response> _post(String url,
      {Map<String, String>? headers, body, encoding}) async {
    if (locator<AppPrefs>().token.getValue().isNotEmpty) {
      headers!['Authorization'] =
          'Bearer ${locator<AppPrefs>().token.getValue()}';
    }

    log('POST-URL:: $url \n BODY: $body \n headers: $headers');
    return await http
        .post(Uri.parse(url), body: body, headers: headers, encoding: encoding)
        .then((Response response) {
      return _handleResponse(response, url);
    });
  }

  Future<Response> _delete(String url, {Map<String, String>? headers}) {
    log('DELETE-URL:: $url  \n Header: $headers');
    if (headers!.containsKey('Authorization')) {
      headers['Authorization'] =
          'Bearer ${locator<AppPrefs>().token.getValue()}';
    }
    return http
        .delete(
      Uri.parse(url),
      headers: headers,
    )
        .then((Response response) {
      return _handleResponse(response, url);
    });
  }

  Future<Response> _put(String url,
      {Map<String, String>? headers, body, encoding}) async {
    log('PUT-URL:: $url  \n BODY: $body');
    if (headers!.containsKey('Authorization')) {
      headers['Authorization'] =
          'Bearer ${locator<AppPrefs>().token.getValue()}';
    }
    return await http
        .put(Uri.parse(url), body: body, headers: headers, encoding: encoding)
        .then((Response response) {
      return _handleResponse(response, url);
    });
  }

  Future<Response> _patch(String url,
      {Map<String, String>? headers, body, encoding}) async {
    log('PATCH-URL:: $url  \n BODY: $body');
    if (headers!.containsKey('Authorization')) {
      headers['Authorization'] =
          'Bearer ${locator<AppPrefs>().token.getValue()}';
    }
    return await http
        .patch(Uri.parse(url), body: body, headers: headers, encoding: encoding)
        .then((Response response) {
      return _handleResponse(response, url);
    });
  }

  Response _handleResponse(Response response, String? url) {
    log('Response ($url):: ${response.body}');
    return response;
  }

  @override
  Future<Response> getJoke() async {
    final Response response = await _get(
      AuthApiUrls.getJoke,
      headers,
    );
    return Future.value(response);
  }
}
