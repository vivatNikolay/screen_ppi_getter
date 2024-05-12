import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'screen_ppi_getter_method_channel.dart';

abstract class ScreenPpiGetterPlatform extends PlatformInterface {
  /// Constructs a ScreenPpiGetterPlatform.
  ScreenPpiGetterPlatform() : super(token: _token);

  static final Object _token = Object();

  static ScreenPpiGetterPlatform _instance = MethodChannelScreenPpiGetter();

  /// The default instance of [ScreenPpiGetterPlatform] to use.
  ///
  /// Defaults to [MethodChannelScreenPpiGetter].
  static ScreenPpiGetterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ScreenPpiGetterPlatform] when
  /// they register themselves.
  static set instance(ScreenPpiGetterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<int?> getScreenPpi();
}
