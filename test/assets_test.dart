import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:screen_ppi_getter/src/resources/resources.dart';

void main() {
  test('assets assets test', () {
    expect(File(Assets.devices).existsSync(), isTrue);
  });
}
