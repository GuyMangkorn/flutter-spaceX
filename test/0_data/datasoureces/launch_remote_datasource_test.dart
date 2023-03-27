import 'dart:convert';

import 'package:space_x_demo/0_data/exceptions/exceptions.dart';
import 'package:space_x_demo/0_data/models/crew_model.dart';
import 'package:space_x_demo/0_data/models/launch_detail_model.dart';
import 'package:space_x_demo/0_data/models/launch_model.dart';
import 'package:space_x_demo/0_data/models/launch_response_model.dart';
import 'package:space_x_demo/0_data/models/launchpad_model.dart';
import 'package:space_x_demo/0_data/models/pagination_data_model.dart';
import 'package:space_x_demo/0_data/models/rocket_model.dart';
import 'package:test/test.dart';
import 'package:http/http.dart';
import 'package:space_x_demo/0_data/datasources/launch_remote_datasource.dart';
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements Client {}

void main() async {
  group('LaunchRemoteDatSource', () {
    Client mockClient = MockClient();
    LaunchRemoteDataSource launchRemoteDataSource =
        LaunchRemoteDataSourceImpl(client: mockClient);
    test('should return list of LaunchResponse when status code was 200 ',
        () async {
      const responseBody =
          '{"docs":[{"id":"test_id", "name": "name_test" , "date_utc": "2022-08-12T21:30:00.000Z" , "success": true , "upcoming": true , "links": {"flickr": {"original" : []} , "patch": {"small" : ""}}}],"hasNextPage": true,"page": 1}';

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
      expect(
        result,
        LaunchResponseModel(
          paginationData: PaginationDataModel(
            hasNextPage: true,
            page: 1,
          ),
          list: const [
            LaunchModel(
              dateUtc: '2022-08-12',
              id: 'test_id',
              name: 'name_test',
              success: true,
              upcoming: true,
              images: [],
              patch: "",
            )
          ],
        ),
      );
    });

    test('should return LaunchModel when status code was 200', () async {
      const responseBody = {
        "docs": [
          {
            "fairings": null,
            "links": {
              "patch": {
                "small": "https://images2.imgbox.com/98/cc/UJd0SS73_o.png",
                "large": "https://images2.imgbox.com/03/3d/LzQWXPfy_o.png"
              },
              "reddit": {
                "campaign":
                    "https://www.reddit.com/r/spacex/comments/iwb8bl/crew1_launch_campaign_thread/",
                "launch":
                    "https://www.reddit.com/r/spacex/comments/ju7fxv/rspacex_crew1_official_launch_coast_docking/",
                "media":
                    "https://www.reddit.com/r/spacex/comments/judv0r/rspacex_crew1_media_thread_photographer_contest/",
                "recovery": null
              },
              "flickr": {
                "small": [],
                "original": [
                  "https://live.staticflickr.com/65535/50618376646_8f52c31fc4_o.jpg",
                  "https://live.staticflickr.com/65535/50618376731_43ddaab1b8_o.jpg",
                  "https://live.staticflickr.com/65535/50618376671_ba4e60af7c_o.jpg",
                  "https://live.staticflickr.com/65535/50618376351_ecfdee4ab2_o.jpg",
                  "https://live.staticflickr.com/65535/50618727917_01e579c4d9_o.jpg",
                  "https://live.staticflickr.com/65535/50618355216_2872d1fe98_o.jpg",
                  "https://live.staticflickr.com/65535/50618354801_ff3e722884_o.jpg",
                  "https://live.staticflickr.com/65535/50618463487_41642939a4_o.jpg",
                  "https://live.staticflickr.com/65535/50617619613_5630422345_o.jpg",
                  "https://live.staticflickr.com/65535/50617619668_d680d7319c_o.jpg",
                  "https://live.staticflickr.com/65535/50617625523_a7484e0abf_o.jpg",
                  "https://live.staticflickr.com/65535/50618469202_fa86f88ab3_o.jpg",
                  "https://live.staticflickr.com/65535/50617625183_8554412cee_o.jpg",
                  "https://live.staticflickr.com/65535/50618470472_fb8e6507d7_o.jpg",
                  "https://live.staticflickr.com/65535/50617626838_c0c71de1f7_o.jpg",
                  "https://live.staticflickr.com/65535/50617626738_aa3997aaea_o.jpg",
                  "https://live.staticflickr.com/65535/50617626408_fb0bba0f89_o.jpg",
                  "https://live.staticflickr.com/65535/51158778650_9b8d555c1e_o.jpg",
                  "https://live.staticflickr.com/65535/51158458619_9b74f6a3d0_o.jpg"
                ]
              },
              "presskit": null,
              "webcast": "https://youtu.be/bnChQbxLkkI",
              "youtube_id": "bnChQbxLkkI",
              "article":
                  "https://spaceflightnow.com/2020/11/16/astronauts-ride-spacex-crew-capsule-in-landmark-launch-for-commercial-spaceflight/",
              "wikipedia": "https://en.wikipedia.org/wiki/SpaceX_Crew-1"
            },
            "static_fire_date_utc": "2020-11-11T16:17:00.000Z",
            "static_fire_date_unix": 1605111420,
            "net": false,
            "window": 0,
            "rocket": {
              "flickr_images": [
                "https://farm1.staticflickr.com/929/28787338307_3453a11a77_b.jpg",
                "https://farm4.staticflickr.com/3955/32915197674_eee74d81bb_b.jpg",
              ],
              "name": "Falcon 9",
              "type": "rocket",
              "active": true,
              "stages": 2,
              "boosters": 0,
              "cost_per_launch": 50000000,
              "success_rate_pct": 98,
              "first_flight": "2010-06-04",
              "country": "United States",
              "company": "SpaceX",
              "wikipedia": "https://en.wikipedia.org/wiki/Falcon_9",
              "description": "test_desp",
              "id": "5e9d0d95eda69973a809d1ec"
            },
            "success": true,
            "failures": [],
            "details": "test_detail",
            "crew": [
              {
                "name": "Shannon Walker",
                "agency": "NASA",
                "image": "https://imgur.com/9z4tRIO.png",
                "wikipedia": "https://en.wikipedia.org/wiki/Shannon_Walker",
                "launches": ["5eb87d4dffd86e000604b38e"],
                "status": "active",
                "id": "5f7f1543bf32c864a529b23e"
              },
            ],
            "launchpad": {
              "images": {
                "large": ["https://i.imgur.com/1jwU0Pk.png"]
              },
              "name": "KSC LC 39A",
              "full_name": "Kennedy Space Center Historic Launch Complex 39A",
              "locality": "Cape Canaveral",
              "region": "Florida",
              "latitude": 28.6080585,
              "longitude": -80.6039558,
              "launch_attempts": 55,
              "launch_successes": 55,
              "rockets": [
                "5e9d0d95eda69973a809d1ec",
                "5e9d0d95eda69974db09d1ed"
              ],
              "timezone": "America/New_York",
              "status": "active",
              "details": "test_detail",
              "id": "5e9e4502f509094188566f88"
            },
            "flight_number": 107,
            "name": "Crew-1",
            "date_utc": "2020-11-16T00:27:00.000Z",
            "date_unix": 1605486420,
            "date_local": "2020-11-15T19:27:00-05:00",
            "date_precision": "hour",
            "upcoming": false,
            "auto_update": true,
            "tbd": false,
            "launch_library_id": null,
            "id": "5eb87d4dffd86e000604b38e"
          }
        ],
      };

      const Map<String, dynamic> payload = {};
      final parseBody = json.encode(payload);

      when(
        () => mockClient.post(
          Uri.parse('https://api.spacexdata.com/v4/launches/query'),
          headers: {'Content-Type': 'application/json'},
          body: parseBody,
        ),
      ).thenAnswer(
        (_) => Future.value(Response(json.encode(responseBody), 200)),
      );

      final result =
          await launchRemoteDataSource.fetchQueryOneLaunch(payload: payload);

      expect(
        result,
        LaunchDetailModel(
            id: '5eb87d4dffd86e000604b38e',
            name: 'Crew-1',
            dateUtc: '2020-11-16',
            success: true,
            upcoming: false,
            details: 'test_detail',
            crew: [
              CrewModel(
                  id: '5f7f1543bf32c864a529b23e',
                  name: 'Shannon Walker',
                  agency: 'NASA',
                  image: 'https://imgur.com/9z4tRIO.png',
                  wikipedia: 'https://en.wikipedia.org/wiki/Shannon_Walker',
                  status: 'active')
            ],
            rocket: RocketModel(
                id: '5e9d0d95eda69973a809d1ec',
                name: 'Falcon 9',
                images: const [
                  'https://farm1.staticflickr.com/929/28787338307_3453a11a77_b.jpg',
                  'https://farm4.staticflickr.com/3955/32915197674_eee74d81bb_b.jpg'
                ],
                successRatePct: 98,
                country: 'United States',
                company: 'SpaceX',
                description: 'test_desp'),
            launchpad: LaunchpadModel(
                id: '5e9e4502f509094188566f88',
                name: 'KSC LC 39A',
                fullName: 'Kennedy Space Center Historic Launch Complex 39A',
                locality: 'Cape Canaveral',
                region: 'Florida',
                launchAttempts: 55,
                launchSuccesses: 55,
                details: "test_detail",
                image: const ['https://i.imgur.com/1jwU0Pk.png']),
            article:
                'https://spaceflightnow.com/2020/11/16/astronauts-ride-spacex-crew-capsule-in-landmark-launch-for-commercial-spaceflight/',
            wikipedia: 'https://en.wikipedia.org/wiki/SpaceX_Crew-1'),
      );
    });

    test(
        'should return ServerException of LaunchListModel when status code was 500 ',
        () async {
      const responseBody = '[{"id":"gr", "name": "Name_Gr"}]';

      const Map<String, dynamic> payload = {};
      final parseBody = json.encode(payload);

      when(
        () => mockClient.post(
          Uri.parse('https://api.spacexdata.com/v4/launches/query'),
          headers: {'Content-Type': 'application/json'},
          body: parseBody,
        ),
      ).thenAnswer(
        (_) => Future.value(Response(responseBody, 500)),
      );

      expect(
        launchRemoteDataSource.fetchQueryAllLaunch(payload),
        throwsA(isA<ServerException>()),
      );
    });

    test(
        'should return BadRequestException of LaunchListModel when status code was 400 or 403',
        () async {
      const responseBody = '[{"id":"gr", "name": "Name_Gr"}]';

      const Map<String, dynamic> payload = {};
      final parseBody = json.encode(payload);

      when(
        () => mockClient.post(
          Uri.parse('https://api.spacexdata.com/v4/launches/query'),
          headers: {'Content-Type': 'application/json'},
          body: parseBody,
        ),
      ).thenAnswer(
        (_) => Future.value(Response(responseBody, 403)),
      );

      expect(
        launchRemoteDataSource.fetchQueryAllLaunch(payload),
        throwsA(isA<BadRequestException>()),
      );
    });
  });
}
