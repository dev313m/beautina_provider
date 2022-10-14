import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

final _firebaseAuth = FirebaseAuth.instance;

Future<String?> signInWithApple() async {
  // 1. perform the sign-in request
  // List<Scope> scopes = [Scope.email, Scope.fullName];

  final credential = await SignInWithApple.getAppleIDCredential(scopes: [
    AppleIDAuthorizationScopes.email,
    AppleIDAuthorizationScopes.fullName,
  ]);

  final oAuthProvider = OAuthProvider('apple.com');
// SignInWithApple.

  final cr = oAuthProvider.credential(
    idToken: credential.identityToken!,
    accessToken: credential.authorizationCode,
  );
  final authResult = await _firebaseAuth.signInWithCredential(cr);

  print(authResult.user.toString());
  return authResult.user?.uid;
  // credential.

  // // 2. check the result
  // switch (credential) {
  //   case AuthorizationCredentialAppleID.authorized:
  //     final appleIdCredential = result.credential!;
  //     final oAuthProvider = OAuthProvider('apple.com');

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
