import 'screen_ppi_getter_platform_interface.dart';

class ScreenPpiGetter {
  Future<int?> getScreenPpi() {
    return ScreenPpiGetterPlatform.instance.getScreenPpi();
  }
}
