import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherx/controllers/home_controller.dart';
import 'package:weatherx/controllers/network_controller.dart';
import 'package:weatherx/controllers/network_controller.dart';
import 'package:weatherx/controllers/weather_page_controller.dart';
import 'package:weatherx/utils/size_config.dart';
import 'package:weatherx/utils/text_styles.dart';
import 'package:weatherx/utils/textform_decoration.dart';
import 'package:weatherx/views/check_preference.dart';
import 'package:weatherx/views/weather_page.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final networkController = Get.find<NetworkController>();
    SizeConfig().init(context);
    return Obx(() => networkController.connectivityStatus.value != 0
        ? Scaffold(
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(SizeConfig.sidePadding,
                    SizeConfig.sidePadding, SizeConfig.sidePadding, 0),
                child: Column(
                  children: [
                    if (homeController.searchLoading.isTrue)
                      Expanded(
                        child: Container(
                          child: Center(
                            child: CupertinoActivityIndicator(),
                          ),
                        ),
                      )
                    else
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              homeController.name.value,
                              style: h2Medium,
                            ),
                            SizedBox(height: SizeConfig.longside / 40),
                            TextFormField(
                              decoration: kTextFormDecoration(
                                  hint: "Enter a valid city name"),
                              controller: homeController.cityController,
                              autofocus: true,
                              onChanged: (value) {
                                homeController.searchCity();
                              },
                            ),
                            SizedBox(height: SizeConfig.longside / 80),
                            Expanded(
                              child: ListView.builder(
                                itemCount: homeController.searchResults.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(vertical: 3),
                                    child: GestureDetector(
                                      onTap: () {
                                        WidgetsBinding
                                            .instance.focusManager.primaryFocus
                                            ?.unfocus();
                                        homeController.setCityIdPreference(
                                            homeController
                                                .searchResults[index].id);
                                        Get.put(WeatherPageController(
                                            id: homeController
                                                .searchResults[index].id));
                                        Get.find<WeatherPageController>()
                                            .changeId(homeController
                                                .searchResults[index].id);
                                        homeController.cityController.clear();
                                        Get.offAll(() => WeatherPage(
                                            id: homeController
                                                .searchResults[index].id));
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(
                                            SizeConfig.cardInnerPadding),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.white30,
                                              width: 0.2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        height: SizeConfig.longside / 20,
                                        child: Text(
                                          "${homeController.searchResults[index].name ?? ""}, ${homeController.searchResults[index].country ?? ""}",
                                          style: h5,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          )
        : NoInternet());
  }
}
