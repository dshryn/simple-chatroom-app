import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chat_app/screens/chat.dart';
import 'firebase_mocks.mocks.dart';

void main() {
  late MockFirebaseAuth mockAuth;
  late MockFirebaseFirestore mockFirestore;
  late MockFirebaseMessaging mockMessaging;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    try {
      await Firebase.initializeApp();
    } catch (e) {
      print('Firebase initialization error: $e');
    }

    mockAuth = MockFirebaseAuth();
    mockFirestore = MockFirebaseFirestore();
    mockMessaging = MockFirebaseMessaging();
  });

  testWidgets('Chat screen loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ChatScreen()));

    expect(find.byType(Expanded), findsWidgets);
    expect(find.byType(TextField), findsOneWidget);
  });
}
