import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:test_val/screen/first_screen.dart';

void main() {
  runApp(MaterialApp(
    home: FirstScreen(),
    supportedLocales: [
      Locale('uk'),
      Locale('en'),
    ],
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      FormBuilderLocalizations.delegate,
    ],
  ));
}
