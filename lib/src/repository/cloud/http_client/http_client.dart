import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc_boilerplate/src/model/response/http_response_model.dart';
import 'package:http/http.dart';
import 'package:http_logger/http_logger.dart';
import 'package:http_middleware/http_middleware.dart';


class HttpClient {
  final String _baseUrl = "https://api.github.com/"; //todo set base_url
  final String _token = "set token"; //todo set token

  final HttpWithMiddleware _http = HttpWithMiddleware.build(
      requestTimeout: Duration(seconds: 30),
      middlewares: [
//        HttpLogger(logLevel: LogLevel.BODY)
        kReleaseMode == false ? HttpLogger(logLevel: LogLevel.BODY) : null,
      ]);

  HttpClient._privateConstructor() {
    //initialization logic here
  }

  static final HttpClient _instance = HttpClient._privateConstructor();

  factory HttpClient() {
    return _instance;
  }

  Future<HttpResponseModel> getRequestApi(String route,
      {String path,
        Map<String, dynamic> queryParameters,
        bool callByToken = false}) async {
    try {
      String queryParams = "";
      if (queryParameters != null && queryParameters.isNotEmpty) {
        queryParameters.forEach((key, value) {
          queryParams.isEmpty
              ? queryParams = key + "=" + value.toString()
              : queryParams = queryParams + "&" + key + "=" + value.toString();
        });
      }
      var response = await _http.get(
          _baseUrl +
              route +
              (path != null && path.isNotEmpty ? "/$path" : "") +
              (queryParams != null && queryParams.isNotEmpty
                  ? "?$queryParams"
                  : ""),
          headers: _getHeaders(callByToken));
      return _handleResponse(response);
    } catch (error) {
      print(error);
      throw error is HttpResponseError
          ? error
          : HttpResponseError(0, "error connection");
      //     return HttpResponseError(0, "error connection");
    }
  }

  FutureOr<HttpResponseModel> postRequestApi(
      String route, Map<String, dynamic> parameters,
      {bool callByToken = false}) async {
    try {
      var response = await _http.post(_baseUrl + route,
          body: jsonEncode(parameters), headers: _getHeaders(callByToken));
      return _handleResponse(response);
    } catch (error) {
      print(error);
      throw error is HttpResponseError
          ? error
          : HttpResponseError(0, "error connection");
      //     return HttpResponseError(0, "error connection");
    }
  }

  FutureOr<HttpResponseModel> putRequestApi(
      String route, Map<String, dynamic> parameters,
      {bool callByToken = false}) async {
    try {
      var response = await _http.put(_baseUrl + route,
          body: jsonEncode(parameters), headers: _getHeaders(callByToken));
      return _handleResponse(response);
    } catch (error) {
      print(error);
      throw error is HttpResponseError
          ? error
          : HttpResponseError(0, "error connection");
      //     return HttpResponseError(0, "error connection");
    }
  }

  HttpResponseModel _handleResponse(Response response) {
    if (response.statusCode > 199 && response.statusCode < 300) {
      return HttpResponseSuccessful(response.body);
    } else {
      //todo handle error of api from response.body
      switch (response.statusCode) {
        case 400:
          throw HttpResponseError(response.statusCode, "Autentication Error");
          break;
        case 500:
          throw HttpResponseError(response.statusCode, "Internal Server Error");
          break;
        case 404:
          throw HttpResponseError(response.statusCode, "Page Not Found");
          break;
        default:
          throw HttpResponseError(response.statusCode, "Error connection");
      }
    }
  }

  Map<String, String> _getHeaders(bool callByToken) {
    var jsonType = "application/json";
    var headers = {"Content-Type": jsonType};
    if (callByToken) {
      headers["Authorization"] = _token;
    }
    return headers;
  }
}
