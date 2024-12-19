import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:screen_ppi_getter/src/models/ios_device.dart';
import 'package:screen_ppi_getter/src/resources/resources.dart';
import 'package:screen_ppi_getter/src/screen_ppi_getter_platform_interface.dart';

class ScreenPpiGetter {
  Future<int?> getScreenPpi() {
    if (Platform.isIOS) {
      return _getScreenPpiForIos();
    }

    return ScreenPpiGetterPlatform.instance.getScreenPpi();
  }

  Future<int?> _getScreenPpiForIos() async {
    final deviceMachineName = await _getDeviceMachineName();
    final allDevices = await _getAllIosDevices();

    final currentDevice = allDevices.firstWhere(
      (element) => element.hardwareNames.contains(deviceMachineName),
    );

    return currentDevice.ppi.toInt();
  }

  Future<String> _getDeviceMachineName() async {
    final deviceInfo = DeviceInfoPlugin();
    final iosInfo = await deviceInfo.iosInfo;

    return iosInfo.utsname.machine;
  }

  Future<List<IosDevice>> _getAllIosDevices() async {
    final allDevicesJson = await rootBundle.loadString(Resources.iosDevices);

    return (json.decode(allDevicesJson) as List<dynamic>)
        .map((e) => IosDevice.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
