import 'dart:convert';

import 'package:space_x_demo/0_data/exceptions/exceptions.dart';
import 'package:space_x_demo/0_data/models/launch_detail_model.dart';
import 'package:space_x_demo/0_data/models/launch_model.dart';
import 'package:http/http.dart' as http;
import 'package:space_x_demo/0_data/models/launch_response_model.dart';

abstract class LaunchRemoteDataSource {
  Future<List<LaunchModel>> fetchAllLaunch();
  Future<LaunchResponseModel> fetchQueryAllLaunch(Map<String, dynamic> payload);
  Future<LaunchDetailModel> fetchQueryOneLaunch(
      {required Map<String, dynamic> payload});
}

class LaunchRemoteDataSourceImpl implements LaunchRemoteDataSource {
  final http.Client client;

  LaunchRemoteDataSourceImpl({required this.client});

  @override
  Future<List<LaunchModel>> fetchAllLaunch() async {
    final response = await client.post(
      Uri.parse('https://api.spacexdata.com/v4/launches'),
      headers: {'Content-Type': 'application/json'},
    );
    final decodeResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      return LaunchModel.fromListJson(decodeResponse);
    } else {
      return MapStatusCode.mapStatusCodeException(response);
    }
  }

  @override
  Future<LaunchResponseModel> fetchQueryAllLaunch(
      Map<String, dynamic> payload) async {
    final parseBody = json.encode(payload);
    final response = await client.post(
      Uri.parse('https://api.spcexdata.com/v4/launches/query'),
      headers: {'Content-Type': 'application/json'},
      body: parseBody,
    );
    final decodeResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      return LaunchResponseModel.fromJson(decodeResponse);
    } else {
      return MapStatusCode.mapStatusCodeException(response);
    }
  }

  @override
  Future<LaunchDetailModel> fetchQueryOneLaunch(
      {required Map<String, dynamic> payload}) async {
    final parseBody = json.encode(payload);
    final response = await client.post(
      Uri.parse('https://api.spacexdata.com/v4/launches/query'),
      headers: {'Content-Type': 'application/json'},
      body: parseBody,
    );
    final decodeResponse = json.decode(response.body);
    if (response.statusCode == 200 && decodeResponse['docs'][0] != null) {
      return LaunchDetailModel.fromJson(decodeResponse['docs'][0]);
    } else {
      return MapStatusCode.mapStatusCodeException(response);
    }
  }
}
