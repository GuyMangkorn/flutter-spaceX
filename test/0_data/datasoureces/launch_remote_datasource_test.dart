import 'dart:convert';

import 'package:test/test.dart';
import 'package:http/http.dart';
import 'package:space_x_demo/0_data/datasources/launch_remote_datasource.dart';
import 'package:mocktail/mocktail.dart';
import 'package:space_x_demo/0_data/models/launch_model.dart';

class MockClient extends Mock implements Client {}

void main() async {
  group('LaunchDatSource', () {
    test('should return list of LaunchListModel when status code was 200 ',
        () async {
      Client mockClient = MockClient();
      LaunchRemoteDataSource launchRemoteDataSource =
          LaunchRemoteDataSourceImpl(client: mockClient);

      const responseBody =
          '{"docs":[{"id":"gr", "name": "Name_Gr" , "date_utc": "2022-08-12T21:30:00.000Z" , "success": true , "upcoming": true}]}';

      const Map<String, dynamic> payload = {};
      final parseBody = json.encode(payload);

      when(
        () => mockClient.post(
          Uri.parse('https://api.spacexdata.com/v4/launches/query'),
          headers: {'Content-Type': 'application/json'},
          body: parseBody,
        ),
      ).thenAnswer(
        (_) => Future.value(Response(responseBody, 200)),
      );

      final result = await launchRemoteDataSource.fetchQueryAllLaunch(payload);

      expect(result, []);
    });

    // test(
    //     'should return list [] of LaunchListModel when status code was not 200 ',
    //     () async {
    //   Client mockClient = MockClient();
    //   LaunchRemoteDataSource launchRemoteDataSource =
    //       LaunchRemoteDataSourceImpl(client: mockClient);

    //   const responseBody = '[{"id":"gr", "name": "Name_Gr"}]';

    //   when(
    //     () => mockClient.get(
    //       Uri.parse('https://api.spacexdata.com/v4/launches'),
    //       headers: {'Content-Type': 'application/json'},
    //     ),
    //   ).thenAnswer(
    //     (_) => Future.value(Response(responseBody, 500)),
    //   );

    //   final result = await launchRemoteDataSource.fetchAllLaunch();

    //   expect(result, []);
    // });
  });
}
