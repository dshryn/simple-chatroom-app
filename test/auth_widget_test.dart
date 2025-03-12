import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chat_app/screens/auth.dart';

void main() {
  testWidgets('Login screen loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: AuthScreen()));

    expect(find.byType(TextField), findsNWidgets(2));

    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
