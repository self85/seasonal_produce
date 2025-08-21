// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:seasonal_produce/main.dart';

void main() {
  testWidgets('App loads and displays produce list', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const InSeasonApp());

    // Wait for the app to load and localization to initialize
    await tester.pumpAndSettle();

    // Verify that the app loads without errors
    expect(find.byType(MaterialApp), findsOneWidget);
    
    // You can add more specific tests here based on your app's UI
    // For example, testing if certain widgets are present
  });

  testWidgets('App has proper localization setup', (WidgetTester tester) async {
    await tester.pumpWidget(const InSeasonApp());
    await tester.pumpAndSettle();

    // Verify that the MaterialApp has localization delegates
    final MaterialApp app = tester.widget(find.byType(MaterialApp));
    expect(app.localizationsDelegates, isNotNull);
    expect(app.supportedLocales, isNotEmpty);
  });
}
