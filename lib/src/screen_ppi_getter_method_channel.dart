import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'screen_ppi_getter_platform_interface.dart';

/// An implementation of [ScreenPpiGetterPlatform] that uses method channels.
class MethodChannelScreenPpiGetter extends ScreenPpiGetterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('screen_ppi_getter');

  @override
  Future<int?> getScreenPpi() {
    return methodChannel.invokeMethod('getScreenPpi');
  }
}
