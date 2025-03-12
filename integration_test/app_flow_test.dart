import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/screens/auth.dart';
import 'package:chat_app/screens/chat.dart';

// ✅ Mock FirebaseAuth
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUser extends Mock implements User {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MockFirebaseAuth mockAuth;
  late MockUser mockUser;

  setUp(() {
    mockAuth = MockFirebaseAuth();
    mockUser = MockUser();
  });

  testWidgets('Full app flow: Login to ChatScreen and send a message',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // ✅ Verify we start on the Splash Screen
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // ✅ Simulate a user logging in
    await tester.pumpAndSettle();
    expect(find.byType(AuthScreen), findsOneWidget);
    await tester.enterText(
        find.byKey(const Key('email_field')), 'test@example.com');
    await tester.enterText(
        find.byKey(const Key('password_field')), 'password123');
    await tester.tap(find.byKey(const Key('login_button')));
    await tester.pumpAndSettle();

    // ✅ Verify we are on the Chat Screen
    expect(find.byType(ChatScreen), findsOneWidget);

    // ✅ Send a message
    await tester.enterText(find.byType(TextField), 'Hello, Chattr!');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();

    // ✅ Verify message appears
    expect(find.text('Hello, Chattr!'), findsOneWidget);
  });
}
