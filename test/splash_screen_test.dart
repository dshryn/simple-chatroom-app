import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/screens/splash.dart';
import 'package:chat_app/screens/chat.dart';
import 'package:chat_app/screens/auth.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUser extends Mock implements User {}

void main() {
  late MockFirebaseAuth mockAuth;
  late MockUser mockUser;

  setUp(() {
    mockAuth = MockFirebaseAuth();
    mockUser = MockUser();
  });

  testWidgets('Splash screen shows loading indicator',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SplashScreen()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Splash screen navigates to ChatScreen if user is logged in',
      (WidgetTester tester) async {
    when(mockAuth.currentUser).thenReturn(mockUser);

    await tester.pumpWidget(MaterialApp(
      home: SplashScreen(),
    ));

    await tester.pumpAndSettle();

    expect(find.byType(ChatScreen), findsOneWidget);
  });

  testWidgets('Splash screen navigates to AuthScreen if user is not logged in',
      (WidgetTester tester) async {
    when(mockAuth.currentUser).thenReturn(null);

    await tester.pumpWidget(MaterialApp(
      home: SplashScreen(),
    ));

    await tester.pumpAndSettle();

    expect(find.byType(AuthScreen), findsOneWidget);
  });
}
