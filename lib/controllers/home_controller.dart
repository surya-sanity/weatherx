import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherx/models/city_list_model.dart';
import 'package:weatherx/services/city_list_service.dart';

class HomeController extends GetxController {
  final TextEditingController cityController = TextEditingController();
  var cityResults = RxList<CityListModel>();
  var searchResults = RxList<CityListModel>();
  var name = RxString("Search Your city");
  var searchLoading = RxBool(false);

  @override
  onInit() {
    super.onInit();
    searchLoading(true);
    CityListService().readJson().then((value) {
      if (value != null) {
        cityResults.value = value;
        searchLoading(false);
      } else {
        searchLoading(false);
        return;
      }
    });
  }

  searchCity() {
    searchResults.clear();
    if (cityController.text.isEmpty) {
      return;
    }
    if (cityController.text.isNotEmpty) {
      cityResults.forEach((element) {
        if (cityController.text
            .toLowerCase()
            .contains(element.name.toLowerCase())) {
          searchResults.add(element);
        }
      });
    }
  }

  setCityIdPreference(int cityId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cityId', cityId);
  }

  Future<int> getCityId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('cityId');
  }

}
