import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:space_x_demo/1_domain/entities/crew_entity.dart';
import 'package:space_x_demo/1_domain/entities/laucnhpad_entity.dart';
import 'package:space_x_demo/1_domain/entities/launch_entity.dart';
import 'package:space_x_demo/1_domain/entities/rocket_entity.dart';
import 'package:space_x_demo/generated/l10n.dart';
import 'package:space_x_demo/theme.dart';

class ConstantsTest {
  static const mockNetworkURL =
      'https://images.pexels.com/photos/2159/flight-sky-earth-space.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';

  static const mockLength = 10;

  static final mockCrews = List.generate(
    mockLength,
    (index) => CrewEntity(
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
    (index) => CrewEntity(
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
    (index) => LaunchEntity(
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
    (index) => LaunchEntity(
      dateUtc: 'dateUtc',
      id: 'id$index',
      name: 'name$index',
      success: true,
      upcoming: false,
      images: const [mockNetworkURL],
      patch: '',
    ),
  );

  static const double maxWidth = 600;
}

Future<void> pumpDeviceBuilderWithThemeWrapper({
  required WidgetTester tester,
  required DeviceBuilder deviceBuilder,
}) async {
  await tester.pumpDeviceBuilder(
    deviceBuilder,
    wrapper: materialAppWrapper(
      localizations: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: AppTheme.darkTheme,
    ),
  );
}

RocketEntity createRocketEntity({
  String id = 'id',
  String name = 'name',
  List<String> images = const [],
  int successRatePct = 0,
  String country = 'country',
  String company = 'company',
  String description =
      'description Est do ad sint irure do.Excepteur labore proident nulla ut in commodo.Excepteur labore enim in minim sunt aliqua.',
}) {
  return RocketEntity(
    id: id,
    name: name,
    images: images,
    successRatePct: successRatePct,
    country: country,
    company: company,
    description: description,
  );
}

LaunchpadEntity createLaunchpadEntity({
  String id = 'id',
  String name = 'name',
  String fullName = 'fullName',
  String locality = 'locality',
  String region = 'region',
  int launchAttempts = 105,
  int launchSuccesses = 105,
  String details =
      'Velit cillum laboris aute sint sunt.Aute ea officia deserunt ea adipisicing fugiat pariatur et cillum.Aliquip voluptate culpa velit tempor incididunt.',
  List<String> image = const [],
}) {
  return LaunchpadEntity(
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
