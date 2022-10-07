import 'dart:async';
import 'package:intl/intl.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:weatherx/models/weather_by_cityid_model.dart';
import 'package:weatherx/services/city_id_service.dart';

class WeatherPageController extends GetxController {
  WeatherPageController({this.id});
  num id = 0;
  var weatherInfo = WeatherByCityIdModel().obs;

  var header = RxString("nothing");
  var dateString = RxString("");
  var timeString = RxString("");
  var hour = RxString("");
  var minute = RxString("");
  var seconds = RxString("");
  var meridian = RxString("");
  var dateWithMonth = RxString("");
  var isLoading = RxBool(false);
  var isCelcius = RxBool(true);

  changeId(num newId) {
    this.id = newId;
    getWeatherInfo();
    update();
  }

  @override
  void onInit() {
    super.onInit();
    timeString.value = _formatTime(DateTime.now());
    dateString.value = _formatDate(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    Timer.periodic(Duration(minutes: 10), (timer) => refreshWeatherPage());
    getWeatherInfo();
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDate = _formatDate(now);
    final String formattedTime = _formatTime(now);
    List timeList = timeString.value.split(":");
    timeString.value = formattedTime;
    dateString.value = formattedDate;
    hour.value = timeList[0];
    minute.value = timeList[1];
    seconds.value = timeList[2];
    meridian.value = timeList[3];
    dateWithMonth.value = _formatDateWithName(now);
  }

  Future getWeatherInfo() async {
    isLoading(true);
    await CityIdService().getWeatherByCityId(this.id).then((newValue) {
      if (newValue != null) {
        weatherInfo.value = newValue;
        isLoading(false);
      } else {
        return;
      }
    });
  }

  Future<Null> refreshWeatherPage() async {
    await Future.wait([
      Future.delayed(Duration(milliseconds: 2000)),
      CityIdService().getWeatherByCityId(this.id).then((refreshedValue) {
        if (refreshedValue != null) {
          weatherInfo.value = refreshedValue;
        }
      }),
    ]);
  }

  String _formatDate(DateTime dateTime) {
    return DateFormat('MM/dd/yyyy').format(dateTime);
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat('hh:mm:ss:a').format(dateTime);
  }

  String _formatDateWithName(DateTime dateTime) {
    return DateFormat('EEEE dd MMM').format(dateTime);
  }

  String getFahr(int deg) {
    return ((deg * (9 / 5)) + 32).ceil().toString();
  }
}
