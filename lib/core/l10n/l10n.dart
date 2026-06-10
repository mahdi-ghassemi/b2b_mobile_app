import 'package:flutter/material.dart';

abstract final class L10n {
  static const fallbackLocale = Locale('en');

  static const supportedLocales = <Locale>[
    Locale('en'),
    Locale('ar'),
    Locale('fa'),
    Locale('ckb'),
    Locale('ku'),
    Locale('tr'),
  ];
}
