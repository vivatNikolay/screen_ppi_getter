import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:screen_ppi_getter/screen_ppi_getter.dart';
import 'package:screen_ppi_getter/src/screen_ppi_getter_method_channel.dart';
import 'package:screen_ppi_getter/src/screen_ppi_getter_platform_interface.dart';

class MockScreenPpiGetterPlatform
    with MockPlatformInterfaceMixin
    implements ScreenPpiGetterPlatform {
  @override
  Future<int?> getScreenPpi() => Future.value(150);
}

void main() {
  final ScreenPpiGetterPlatform initialPlatform =
      ScreenPpiGetterPlatform.instance;

  test('$MethodChannelScreenPpiGetter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelScreenPpiGetter>());
  });

  test('getScreenPpi', () async {
    ScreenPpiGetter screenPpiGetterPlugin = ScreenPpiGetter();
    MockScreenPpiGetterPlatform fakePlatform = MockScreenPpiGetterPlatform();
    ScreenPpiGetterPlatform.instance = fakePlatform;

    expect(await screenPpiGetterPlugin.getScreenPpi(), 150);
  });
}
