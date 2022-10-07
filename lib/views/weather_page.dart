import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:weatherx/controllers/network_controller.dart';
import 'package:weatherx/controllers/weather_page_controller.dart';
import 'package:weatherx/utils/bottom_delayed_animation.dart';
import 'package:weatherx/utils/marquee_widget.dart';
import 'package:weatherx/utils/scale_animation.dart';
import 'package:weatherx/utils/size_config.dart';
import 'package:weatherx/utils/text_styles.dart';
import 'package:weatherx/views/check_preference.dart';
import 'package:weatherx/views/home.dart';

class WeatherPage extends StatelessWidget {
  final num id;
  WeatherPage({this.id});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final controller = Get.find<WeatherPageController>();
    final networkController = Get.find<NetworkController>();

    return Obx(() => networkController.connectivityStatus.value != 0
        ? Scaffold(
            body: SafeArea(
                child: controller.isLoading.isTrue
                    ? Container(
                        height: SizeConfig.screenHeight,
                        width: SizeConfig.screenWidth,
                        child: Center(
                          child: CupertinoActivityIndicator(),
                        ),
                      )
                    : BottomDelayedAnimation(
                        animationDuration: Duration(milliseconds: 700),
                        curve: Curves.elasticInOut,
                        delayDuration: Duration(microseconds: 0),
                        child: Column(
                          children: [
                            Expanded(
                              child: RefreshIndicator(
                                onRefresh: controller.refreshWeatherPage,
                                triggerMode:
                                    RefreshIndicatorTriggerMode.anywhere,
                                child: ListView(
                                  physics: BouncingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics()),
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        HapticFeedback.lightImpact();
                                        controller.isCelcius.value =
                                            !controller.isCelcius.value;
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(
                                            SizeConfig.sidePadding),
                                        width: double.maxFinite,
                                        height: SizeConfig.longside / 1.15,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              stops: [
                                                0.1,
                                                0.2,
                                                0.4,
                                                0.6,
                                                0.8,
                                              ],
                                              colors: [
                                                Color(0xff11B2FE),
                                                Color(0xff26B9F0),
                                                Color(0xff18B0EB),
                                                Color(0xff1590F6),
                                                Color(0xff1478F6),
                                              ],
                                            )),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            MarqueeWidget(
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8.0),
                                                    child: Icon(
                                                        Icons.room_outlined),
                                                  ),
                                                  Text(
                                                    "${controller.weatherInfo.value.name ?? ""}, ${controller.weatherInfo.value.sys.country ?? ""}",
                                                    style: h2Medium,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                                height:
                                                    SizeConfig.longside / 40),
                                            BuildImage(),
                                            SizedBox(
                                                height:
                                                    SizeConfig.longside / 40),
                                            Container(
                                              child: RichText(
                                                text: TextSpan(
                                                  text:
                                                      controller.isCelcius.value
                                                          ? controller
                                                              .weatherInfo
                                                              .value
                                                              .main
                                                              .temp
                                                              .ceil()
                                                              .toString()
                                                          : controller.getFahr(
                                                              controller
                                                                  .weatherInfo
                                                                  .value
                                                                  .main
                                                                  .temp
                                                                  .ceil()),
                                                  style: mainHeader.copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      height: 1,
                                                      fontSize:
                                                          SizeConfig.longside /
                                                              7),
                                                  children: [
                                                    TextSpan(
                                                        text: controller
                                                                .isCelcius.value
                                                            ? "\u2103"
                                                            : "\u2109",
                                                        style: h4.copyWith(
                                                            height: 1)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                                height:
                                                    SizeConfig.longside / 100),
                                            Flexible(
                                              child: Text(
                                                controller.weatherInfo.value
                                                        .weather[0].main ??
                                                    "",
                                                textAlign: TextAlign.center,
                                                style: h1Medium,
                                                maxLines: 1,
                                              ),
                                            ),
                                            SizedBox(
                                                height:
                                                    SizeConfig.longside / 100),
                                            Text(
                                              controller.dateWithMonth.value ??
                                                  "",
                                              style: h6.copyWith(
                                                  color: Colors.white70,
                                                  fontSize:
                                                      SizeConfig.longside / 70),
                                            ),
                                            SizedBox(
                                                height:
                                                    SizeConfig.longside / 40),
                                            Divider(
                                              color: Colors.white,
                                              height: 2,
                                            ),
                                            SizedBox(
                                                height:
                                                    SizeConfig.longside / 30),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    child: Column(
                                                      children: [
                                                        Icon(
                                                          FontAwesomeIcons.wind,
                                                          size: 24,
                                                        ),
                                                        SizedBox(
                                                            height: SizeConfig
                                                                    .longside /
                                                                80),
                                                        Text(
                                                          "${controller.weatherInfo.value.wind.speed.ceil().toString() ?? ""} m/s",
                                                          style: h5,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5.0),
                                                          child: Text(
                                                            "Wind",
                                                            style: h5,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    child: Column(
                                                      children: [
                                                        Icon(
                                                          FontAwesomeIcons.tint,
                                                          size: 24,
                                                        ),
                                                        SizedBox(
                                                            height: SizeConfig
                                                                    .longside /
                                                                80),
                                                        Text(
                                                          "${controller.weatherInfo.value.main.humidity.ceil().toString() ?? ""} %",
                                                          style: h5,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5.0),
                                                          child: Text(
                                                            "Humidity",
                                                            style: h5,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    child: Column(
                                                      children: [
                                                        Icon(
                                                          FontAwesomeIcons
                                                              .temperatureHigh,
                                                          size: 24,
                                                        ),
                                                        SizedBox(
                                                            height: SizeConfig
                                                                    .longside /
                                                                80),
                                                        Text(
                                                          controller.isCelcius
                                                                  .value
                                                              ? "${controller.weatherInfo.value.main.feelsLike.ceil().toString() ?? ""} \u2103"
                                                              : "${controller.getFahr(controller.weatherInfo.value.main.feelsLike.ceil()) ?? ""}\u2109",
                                                          style: h5,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5.0),
                                                          child: Text(
                                                            "Feels Like",
                                                            style: h5,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              SizeConfig.cardInnerPadding),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.all(
                                                      SizeConfig
                                                          .cardInnerPadding),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "${controller.weatherInfo.value.name ?? ""}, ${controller.weatherInfo.value.sys.country ?? ""}",
                                                        style: h4Medium,
                                                      ),
                                                      InkResponse(
                                                        onTap: () {
                                                          Get.to(() => Home());
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              "Change City",
                                                              style: h4,
                                                            ),
                                                            Icon(Icons
                                                                .arrow_right)
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
          )
        : NoInternet());
  }
}

class BuildImage extends StatefulWidget {
  @override
  _BuildImageState createState() => _BuildImageState();
}

class _BuildImageState extends State<BuildImage> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WeatherPageController>();
    return ScaleAnimation(
      animationDuration: Duration(seconds: 8),
      begin: 0.9,
      end: 1.2,
      child: SizedBox(
        height: SizeConfig.shortside / 1.8,
        width: SizeConfig.shortside / 2,
        child: checkWeather(controller),
      ),
    );
  }

  checkWeather(WeatherPageController controller) {
    final main = controller.weatherInfo.value?.weather[0].main;
    var hour = DateTime.now().hour;
    if (hour >= 7 && hour <= 17) {
      if (main == "Thunderstorm" || main.toLowerCase().contains("thunderstorm"))
        return getImage('assets/images/thunderstorm.png');
      else if (main == "Drizzle" || main.toLowerCase().contains("drizzle"))
        return getImage('assets/images/drizzle.png');
      else if (main == "Rain" || main.toLowerCase().contains("rain"))
        return getImage('assets/images/rain.png');
      else if (main == "Snow" || main.toLowerCase().contains("snow"))
        return getImage('assets/images/snow.png');
      else if (main == "Clear" || main.toLowerCase().contains("clear"))
        return getImage('assets/images/day_clear.png');
      else if (main == "Clouds" || main.toLowerCase().contains("clouds"))
        return getImage('assets/images/day_cloudy.png');
      else if (main == "Tornado" || main.toLowerCase().contains("tornado"))
        return getImage('assets/images/tornado.png');
      else
        return getImage('assets/images/snow_misc.png');
    } else if ((hour >= 0 && hour <= 6) || (hour >= 18 && hour <= 24)) {
      if (main == "Thunderstorm" || main.toLowerCase().contains("thunderstorm"))
        return getImage('assets/images/thunderstorm.png');
      else if (main == "Drizzle" || main.toLowerCase().contains("drizzle"))
        return getImage('assets/images/drizzle.png');
      else if (main == "Rain" || main.toLowerCase().contains("rain"))
        return getImage('assets/images/rain.png');
      else if (main == "Snow" || main.toLowerCase().contains("snow"))
        return getImage('assets/images/snow.png');
      else if (main == "Clear" || main.toLowerCase().contains("clear"))
        return getImage('assets/images/night_clear.png');
      else if (main == "Clouds" || main.toLowerCase().contains("clouds"))
        return getImage('assets/images/clouds.png');
      else if (main == "Tornado" || main.toLowerCase().contains("tornado"))
        return getImage('assets/images/tornado.png');
      else
        return getImage('assets/images/snow_misc.png');
    }
  }

  getImage(String path) {
    return Image.asset(path, fit: BoxFit.contain);
  }
}
