// Basic smoke test: the app boots and shows both converter tabs.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:convert_rai/main.dart';

void main() {
  setUpAll(() async {
    // Hive.initFlutter() relies on path_provider platform channels, which
    // aren't available under the plain VM test runner, so point Hive at a
    // temp directory directly instead.
    Hive.init(Directory.systemTemp.createTempSync('hive_test').path);
  });

  testWidgets('App boots and shows both converter tabs',
      (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: ConverRaiApp()));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.change_circle_outlined), findsOneWidget);
    expect(find.byIcon(Icons.currency_exchange_outlined), findsOneWidget);
  });
}
