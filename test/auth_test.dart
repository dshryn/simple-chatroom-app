import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'auth_test.mocks.dart';

@GenerateMocks([FirebaseAuth, User, UserCredential])
void main() {
  final mockAuth = MockFirebaseAuth();
  final mockUserCredential = MockUserCredential();
  final mockUser = MockUser();

  group('Auth Tests', () {
    test('User successfully logs in', () async {
      when(mockAuth.signInWithEmailAndPassword(
        email: "test@example.com",
        password: "password123",
      )).thenAnswer((_) async => mockUserCredential);

      when(mockUserCredential.user).thenReturn(mockUser);

      final result = await mockAuth.signInWithEmailAndPassword(
        email: "test@example.com",
        password: "password123",
      );

      expect(result, isA<UserCredential>());
    });

    test('User login fails with incorrect credentials', () async {
      when(mockAuth.signInWithEmailAndPassword(
        email: "wrong@example.com",
        password: "wrongpassword",
      )).thenThrow(FirebaseAuthException(code: "user-not-found"));

      expect(
        () async => await mockAuth.signInWithEmailAndPassword(
          email: "wrong@example.com",
          password: "wrongpassword",
        ),
        throwsA(isA<FirebaseAuthException>()),
      );
    });
  });
}
