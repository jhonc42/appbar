import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:miappbar/l10n/messages_all.dart';

// import 'l10n/messages_all.dart';

class MyLocalizations {
  MyLocalizations(this.localeName);

  final String localeName;

  static MyLocalizations of(BuildContext context) {
    return Localizations.of<MyLocalizations>(context, MyLocalizations);
  }

  static Future<MyLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      return MyLocalizations(localeName);
    });
  }

  String get title {
    return Intl.message(
      'App Bar',
      name: 'title',
      desc: 'App title',
      locale: localeName,
    );
  }

  String get welcome_label {
    return Intl.message(
      'Welcome',
      name: 'welcome_label',
      desc: 'Welcome message',
      locale: localeName,
    );
  }

  String get choosesong_hint {
    return Intl.message(
      'Choose Song',
      name: 'choosesong_hint',
      desc: 'Choose song',
      locale: localeName,
    );
  }

  // String get eventdate_label {
  //   return Intl.message(
  //     'Event Date',
  //     name: 'eventdate_label',
  //     desc: 'Event date',
  //     locale: localeName,
  //   );
  // }

  // String get eventdate_hint {
  //   return Intl.message(
  //     'Enter event date',
  //     name: 'eventdate_hint',
  //     desc: 'Event date hint',
  //     locale: localeName,
  //   );
  // }

  // String get category_label {
  //   return Intl.message(
  //     'Category',
  //     name: 'category_label',
  //     desc: 'Category label',
  //     locale: localeName,
  //   );
  // }

  // String get category_hint {
  //   return Intl.message(
  //     'Choose a seat category',
  //     name: 'category_hint',
  //     desc: 'Category hint',
  //     locale: localeName,
  //   );
  // }

  // String get amount_label {
  //   return Intl.message(
  //     'Amount',
  //     name: 'amount_label',
  //     desc: 'Amount label',
  //     locale: localeName,
  //   );
  // }

  // String get amount_hint {
  //   return Intl.message(
  //     'Enter number of tickets',
  //     name: 'amount_hint',
  //     desc: 'Amount hint',
  //     locale: localeName,
  //   );
  // }

  // String get order {
  //   return Intl.message(
  //     'Order',
  //     name: 'order',
  //     desc: 'order button',
  //     locale: localeName,
  //   );
  // }

  // String get confirmation {
  //   return Intl.message(
  //     'You ordered XXX tickets for a total of \$YYY.',
  //     name: 'confirmation',
  //     desc: 'Confirmation',
  //     locale: localeName,
  //   );
  // }
}

class MyLocalizationsDelegate extends LocalizationsDelegate<MyLocalizations> {
  const MyLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'es', 'fr'].contains(locale.languageCode);
  }

  @override
  Future<MyLocalizations> load(Locale locale) {
    return MyLocalizations.load(locale);
  }

  @override
  bool shouldReload(MyLocalizationsDelegate old) => false;
}
