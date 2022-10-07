import 'dart:convert';

import 'package:get/get.dart';
import 'package:weatherx/constants/app_constants.dart';
import 'package:weatherx/models/weather_by_cityid_model.dart';
import 'package:http/http.dart' as http;

class CityIdService {
  Future<WeatherByCityIdModel> getWeatherByCityId(id) async {
    final response =
        await http.get(Uri.parse(AppConstants().idUrl(cityId: id)));
    if (response.statusCode == 200) {
      return WeatherByCityIdModel.fromJson(jsonDecode(response.body));
    } else {
      Get.snackbar("Something Went wrong", "Couldn't get the Weather Info");
      return null;
    }
  }
}
