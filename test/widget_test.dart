import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:examen1/main.dart';

void main() {
  testWidgets('Navigate to Noticias screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that the Menu Principal screen is displayed.
    expect(find.text('Menu Principal'), findsOneWidget);

    // Tap the 'Noticias' list tile and trigger a frame.
    await tester.tap(find.text('Noticias'));
    await tester.pumpAndSettle();

    // Verify that the Espacio Noticias screen is displayed.
    expect(find.text('Noticias'), findsOneWidget); 
    expect(find.byType(ListView), findsOneWidget); 
  });
}
