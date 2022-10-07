import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:connectivity/connectivity.dart';

class NetworkController extends GetxController {
  var connectivityStatus = 0.obs;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void onInit() {
    super.onInit();
    initConnnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> initConnnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return _updateConnectionStatus(result);
  }

  _updateConnectionStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        connectivityStatus.value = 1;
        break;
      case ConnectivityResult.mobile:
        connectivityStatus.value = 2;
        break;
      case ConnectivityResult.none:
        connectivityStatus.value = 0;
        break;
      default:
        Get.snackbar("Network Error", "Failed to get internet connection");
        break;
    }
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }
}
