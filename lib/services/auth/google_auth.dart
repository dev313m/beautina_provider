import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn(
  scopes: [
    'email',
  ],
);

//return
Future<String> signInWithGoogle() async {
  try {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final AuthResult authResult =
        (await _auth.signInWithCredential(credential));
    FirebaseUser user = authResult.user;
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    if (user.uid == currentUser.uid) return user.uid;
    return null;
  } catch (e) {
    print(e.toString());
    throw Exception(
        "حدثت مشكلة في المصادقة، الرجاء اعادة المحاولة ${e.toString()}");
  }
}

void signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Sign Out");
}
