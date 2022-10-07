import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherx/controllers/home_controller.dart';
import 'package:weatherx/controllers/weather_page_controller.dart';
import 'package:weatherx/utils/size_config.dart';
import 'package:weatherx/views/home.dart';
import 'package:weatherx/views/weather_page.dart';

class CheckPreference extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final controller = Get.put(HomeController());
    return FutureBuilder(
      future: controller.getCityId(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Home();
        } else if (snapshot.hasData && snapshot.data is int) {
          Get.put(WeatherPageController(id: snapshot.data));
          return WeatherPage(
            id: snapshot.data,
          );
        }
        return Scaffold(
            body: SafeArea(
                child: Column(
          children: [
            Expanded(
              child: Container(
                child: Center(
                  child: CupertinoActivityIndicator(),
                ),
              ),
            ),
          ],
        )));
      },
    );
  }
}

class NoInternet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        Expanded(
          child: Container(
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          ),
        ),
      ],
    )));
  }
}
