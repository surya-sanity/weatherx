import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherx/bindings/network_binding.dart';
import 'package:weatherx/utils/theme.dart';
import 'package:weatherx/views/check_preference.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: KTheme.darkTheme,
      home: CheckPreference(),
      initialBinding: NetworkBinding(),
    );
  }
}
