import 'dart:convert';

List<CityListModel> cityListModelFromJson(String str) =>
    List<CityListModel>.from(
        json.decode(str).map((x) => CityListModel.fromJson(x)));

String cityListModelToJson(List<CityListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CityListModel {
  CityListModel({
    this.id,
    this.name,
    this.state,
    this.country,
    this.coord,
  });

  num id;
  String name;
  String state;
  String country;
  Coord coord;

  factory CityListModel.fromJson(Map<String, dynamic> json) => CityListModel(
        id: json["id"],
        name: json["name"],
        state: json["state"],
        country: json["country"],
        coord: Coord.fromJson(json["coord"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "state": state,
        "country": country,
        "coord": coord.toJson(),
      };
}

class Coord {
  Coord({
    this.lon,
    this.lat,
  });

  double lon;
  double lat;

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lon: json["lon"].toDouble(),
        lat: json["lat"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lon": lon,
        "lat": lat,
      };
}
