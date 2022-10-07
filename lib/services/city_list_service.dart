import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:weatherx/models/city_list_model.dart';

class CityListService {
  Future<List<CityListModel>> readJson() async {
    final String response =
        await rootBundle.loadString('assets/json/city.list.json');
    List<dynamic> jsonResponse = await json.decode(response);
    return jsonResponse
        .map<CityListModel>((element) => new CityListModel.fromJson(element))
        .toList();
  }
}
