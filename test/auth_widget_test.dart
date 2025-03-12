import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chat_app/screens/auth.dart';

void main() {
  testWidgets('Login screen loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: AuthScreen()));

    // ✅ Check if email and password text fields exist
    expect(find.byType(TextField), findsNWidgets(2));

    // ✅ Check if the login button is present
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
