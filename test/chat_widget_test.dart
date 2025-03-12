import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mockito/mockito.dart';
import 'package:chat_app/screens/chat.dart';
import 'firebase_mocks.mocks.dart'; // Import generated mocks

void main() {
  late MockFirebaseAuth mockAuth;
  late MockFirebaseFirestore mockFirestore;
  late MockFirebaseMessaging mockMessaging;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    try {
      await Firebase.initializeApp();
    } catch (e) {
      // Ignore if Firebase is already initialized
    }

    // Mock Firebase instances
    mockAuth = MockFirebaseAuth();
    mockFirestore = MockFirebaseFirestore();
    mockMessaging = MockFirebaseMessaging();
  });

  testWidgets('Chat screen loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ChatScreen()));

    // ✅ Check if ChatMessages & NewMessage widgets exist
    expect(find.byType(Expanded), findsWidgets);
    expect(find.byType(TextField), findsOneWidget);
  });
}
