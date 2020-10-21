import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

final _firebaseAuth = FirebaseAuth.instance;

Future<String> signInWithApple({List<Scope> scopes = const []}) async {
  // 1. perform the sign-in request
  List<Scope> scopes = [Scope.email, Scope.fullName];
  final result = await AppleSignIn.performRequests(
      [AppleIdRequest(requestedScopes: scopes)]);
  // 2. check the result
  switch (result.status) {
    case AuthorizationStatus.authorized:
      final appleIdCredential = result.credential;
      final oAuthProvider = OAuthProvider(providerId: 'apple.com');
      final credential = oAuthProvider.getCredential(
        idToken: String.fromCharCodes(appleIdCredential.identityToken),
        accessToken: String.fromCharCodes(appleIdCredential.authorizationCode),
      );
      final authResult = await _firebaseAuth.signInWithCredential(credential);
      final firebaseUser = authResult.user;

      return firebaseUser.uid;
    case AuthorizationStatus.error:
      print(result.error.toString());
      throw PlatformException(
        code: 'ERROR_AUTHORIZATION_DENIED',
        message: result.error.toString(),
      );

    case AuthorizationStatus.cancelled:
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
  }
  return null;
}
