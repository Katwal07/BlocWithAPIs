import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:favourite_item/data/exceptions/app_exception.dart';
import 'package:favourite_item/data/network/base_api_service.dart';
import 'package:http/http.dart' as http;

class NetworkServiceApi implements BaseApiService {
  @override
  Future<dynamic> getApi(String url) async {
    dynamic jsonResponse;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 50));
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw NoInternetException();
    } on TimeoutException {
      throw RequestTimeOutException();
    } on FormatException {
      throw FetchDataException('Error formatting data');
    } on HttpException {
      throw FetchDataException('HTTP error');
    } catch (e) {
      throw FetchDataException('Unexpected error: $e');
    }
    return jsonResponse;
  }

  @override
  Future postApi(String url, var data) async {
    dynamic jsonResponse;
    try {
      final response = await http
          .post(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 50));
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw NoInternetException();
    } on TimeoutException {
      throw FetchDataException();
    } on FormatException {
      throw FetchDataException('Error formatting data');
    } on HttpException {
      throw FetchDataException('HTTP error');
    } catch (e) {
      throw FetchDataException('Unexpected error: $e');
    }
    return jsonResponse;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        /// The server successfully processed the request from the client.
        dynamic jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      case 400:
        /// The server couldnot understand the request due to an issue with the client.
        throw BadRequestException('Bad request');
      case 401:
        /// The server has rejected the request due to lack of proper authentication crediential.
       throw UnAuthorizedException('Unauthorized');
      case 403:
        /// The server understand the request but is refusing to fulfil it due to insufficient permission.
        throw ForbiddenException();
      case 404:
        /// The server cound not find the requested resource.
        throw NotFoundException('Resource not found');
      case 500:
        /// The server encountered an unexpected error while processing the request.
        throw InternalServerErrorException('Server error');
      case 502:
        /// The server acting as a gateway or proxy encountered an issue while trying to fulfil request.
        throw InternalServerErrorException('Server error');
      case 503:
        /// The server is currently unavailable and cannot fulfil the request at the moment.
        throw InternalServerErrorException('Server error');
      case 504:
        /// The server acting as a gateway or proxy encountered a timeout while trying to fulfil the request.
        throw InternalServerErrorException('Server error');
      default:
        throw FetchDataException(
            'Error occurred with status code: ${response.statusCode}');
    }
  }
}
