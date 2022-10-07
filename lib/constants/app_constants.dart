class AppConstants {
  static const apiKey = "74a02073ef77ca700899f5f065c83e72";
  static const url = "https://api.openweathermap.org/data/2.5/weather";
  static const imageUrl = "https://openweathermap.org/img/wn/";

  idUrl<String>({String cityId}) {
    return "$url?id=$cityId&units=metric&appid=$apiKey";
  }

  nameUrl<String>({String cityName}) {
    return "$url?q=$cityName&units=metric&appid=$apiKey";
  }

  getImageUrl<String>({String iconString, int size = 2}) {
    return "$imageUrl$iconString@4x.png";
  }
}
