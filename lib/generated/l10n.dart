// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `SpaceXL`
  String get title {
    return Intl.message(
      'SpaceXL',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Upcoming`
  String get upcoming {
    return Intl.message(
      'Upcoming',
      name: 'upcoming',
      desc: '',
      args: [],
    );
  }

  /// `Search...`
  String get hint_text {
    return Intl.message(
      'Search...',
      name: 'hint_text',
      desc: '',
      args: [],
    );
  }

  /// `Rocket`
  String get rocket {
    return Intl.message(
      'Rocket',
      name: 'rocket',
      desc: '',
      args: [],
    );
  }

  /// `Crews`
  String get crews {
    return Intl.message(
      'Crews',
      name: 'crews',
      desc: '',
      args: [],
    );
  }

  /// `Launchpad`
  String get launchpad {
    return Intl.message(
      'Launchpad',
      name: 'launchpad',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get filter {
    return Intl.message(
      'Filter',
      name: 'filter',
      desc: '',
      args: [],
    );
  }

  /// `By name`
  String get by_name {
    return Intl.message(
      'By name',
      name: 'by_name',
      desc: '',
      args: [],
    );
  }

  /// `A-Z`
  String get a_z {
    return Intl.message(
      'A-Z',
      name: 'a_z',
      desc: '',
      args: [],
    );
  }

  /// `Z-A`
  String get z_a {
    return Intl.message(
      'Z-A',
      name: 'z_a',
      desc: '',
      args: [],
    );
  }

  /// `By launch date`
  String get by_launch_date {
    return Intl.message(
      'By launch date',
      name: 'by_launch_date',
      desc: '',
      args: [],
    );
  }

  /// `Newer`
  String get newer {
    return Intl.message(
      'Newer',
      name: 'newer',
      desc: '',
      args: [],
    );
  }

  /// `Older`
  String get older {
    return Intl.message(
      'Older',
      name: 'older',
      desc: '',
      args: [],
    );
  }

  /// `Loading`
  String get loading_more {
    return Intl.message(
      'Loading',
      name: 'loading_more',
      desc: '',
      args: [],
    );
  }

  /// `Status: Launched`
  String get status_launched {
    return Intl.message(
      'Status: Launched',
      name: 'status_launched',
      desc: '',
      args: [],
    );
  }

  /// `Launched status:`
  String get launch_status {
    return Intl.message(
      'Launched status:',
      name: 'launch_status',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message(
      'Success',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Failure`
  String get failure {
    return Intl.message(
      'Failure',
      name: 'failure',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'th'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
