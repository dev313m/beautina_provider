import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

final _firebaseAuth = FirebaseAuth.instance;

Future<String?> signInWithApple() async {
  // 1. perform the sign-in request
  // List<Scope> scopes = [Scope.email, Scope.fullName];
  final credential = await SignInWithApple.getAppleIDCredential(scopes: [
    AppleIDAuthorizationScopes.email,
    AppleIDAuthorizationScopes.fullName,
  ]);
// SignInWithApple.
  return credential.userIdentifier;

  // credential.

  // // 2. check the result
  // switch (credential) {
  //   case AuthorizationCredentialAppleID.authorized:
  //     final appleIdCredential = result.credential!;
  //     final oAuthProvider = OAuthProvider('apple.com');
  //     final credential = oAuthProvider.credential(
  //       idToken: String.fromCharCodes(appleIdCredential.identityToken!),
  //       accessToken: String.fromCharCodes(appleIdCredential.authorizationCode!),
  //     );
  //     final authResult = await _firebaseAuth.signInWithCredential(credential);
  //     final firebaseUser = authResult.user!;

  //     return firebaseUser.uid;
  //   case AuthorizationStatus.authorized:
  //     print(result.error.toString());
  //     throw PlatformException(
  //       code: 'ERROR_AUTHORIZATION_DENIED',
  //       message: result.error.toString(),
  //     );

  //   case AuthorizationStatus.cancelled:
  //     throw PlatformException(
  //       code: 'ERROR_ABORTED_BY_USER',
  //       message: 'Sign in aborted by user',
  //     );
  // }
}
