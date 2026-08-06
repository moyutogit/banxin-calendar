import 'dart:math';

import 'package:banxin_calendar/core/ids/stable_id_generator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('generates an RFC 4122 version 4 UUID shape', () {
    final generator = UuidV4Generator(secureRandom: Random(7));

    final id = generator.generate();

    expect(
      id,
      matches(
        RegExp(
          r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
        ),
      ),
    );
  });
}
