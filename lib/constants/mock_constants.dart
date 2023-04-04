import 'package:space_x_demo/0_data/models/crew_model.dart';
import 'package:space_x_demo/0_data/models/launch_model.dart';
import 'package:space_x_demo/0_data/models/launchpad_model.dart';
import 'package:space_x_demo/0_data/models/rocket_model.dart';

class MockConstants {
  static const mockNetworkURL =
      'https://images.pexels.com/photos/2159/flight-sky-earth-space.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';

  static const mockLength = 10;

  static final mockCrews = List.generate(
    mockLength,
    (index) => CrewModel(
      id: 'id',
      name: 'name$index',
      agency: 'agency',
      image: '',
      wikipedia: 'wikipedia',
      status: 'status',
    ),
  );

  static final mockNetworkImageCrews = List.generate(
    mockLength,
    (index) => CrewModel(
      id: 'id',
      name: 'name$index',
      agency: 'agency',
      image: mockNetworkURL,
      wikipedia: 'wikipedia',
      status: 'status',
    ),
  );

  static final mockListLaunch = List.generate(
    mockLength,
    (index) => LaunchModel(
      dateUtc: 'dateUtc',
      id: 'id$index',
      name: 'name$index',
      success: true,
      upcoming: false,
      images: const [],
      patch: '',
    ),
  );

  static final mockListLaunchNetworkImage = List.generate(
    mockLength,
    (index) => LaunchModel(
      dateUtc: 'dateUtc',
      id: 'id$index',
      name: 'name$index',
      success: true,
      upcoming: false,
      images: const [mockNetworkURL],
      patch: '',
    ),
  );

  static LaunchpadModel createLaunchpadEntity({
    String id = 'id',
    String name = 'spaceX',
    String fullName = 'spaceX by SpaceX',
    String locality = 'locality',
    String region = 'region',
    int launchAttempts = 105,
    int launchSuccesses = 105,
    String details =
        'Velit cillum laboris aute sint sunt.Aute ea officia deserunt ea adipisicing fugiat pariatur et cillum.Aliquip voluptate culpa velit tempor incididunt.',
    List<String> image = const [],
  }) {
    return LaunchpadModel(
      id: id,
      name: name,
      fullName: fullName,
      locality: locality,
      region: region,
      launchAttempts: launchAttempts,
      launchSuccesses: launchSuccesses,
      details: details,
      image: image,
    );
  }

  static RocketModel createRocketEntity({
    String id = 'id',
    String name = 'name',
    List<String> images = const [],
    int successRatePct = 0,
    String country = 'country',
    String company = 'company',
    String description =
        'description Est do ad sint irure do.Excepteur labore proident nulla ut in commodo.Excepteur labore enim in minim sunt aliqua.',
  }) {
    return RocketModel(
      id: id,
      name: name,
      images: images,
      successRatePct: successRatePct,
      country: country,
      company: company,
      description: description,
    );
  }
}
