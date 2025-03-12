import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/widgets/new_meassage.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  late MockFirebaseAuth mockAuth;
  late MockFirebaseFirestore mockFirestore;

  setUp(() {
    mockAuth = MockFirebaseAuth();
    mockFirestore = MockFirebaseFirestore();
  });

  testWidgets('New message input field and send button exist',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(const MaterialApp(home: Scaffold(body: NewMessage())));

    // ✅ Check if the message input field exists
    expect(find.byType(TextField), findsOneWidget);

    // ✅ Check if the send button exists
    expect(find.byIcon(Icons.send), findsOneWidget);
  });

  testWidgets('Typing and sending a message', (WidgetTester tester) async {
    await tester
        .pumpWidget(const MaterialApp(home: Scaffold(body: NewMessage())));

    // ✅ Enter text in the message field
    await tester.enterText(find.byType(TextField), 'Hello, world!');

    // ✅ Tap the send button
    await tester.tap(find.byIcon(Icons.send));
    await tester.pump();

    // ✅ Ensure text field is cleared after sending
    expect(find.text('Hello, world!'), findsNothing);
  });
}
