import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn(
  scopes: [
    'email',
  ],
);

//return
Future<String?> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;

    if (googleSignInAuthentication == null) throw Exception('Login exception');
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final UserCredential authResult =
        (await _auth.signInWithCredential(credential));
    User user = authResult.user!;
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser!;
    if (user.uid == currentUser.uid) return user.uid;
    return null;
  } catch (e) {
    print(e.toString());
    throw Exception(
        "حدثت مشكلة في المصادقة، الرجاء اعادة المحاولة ${e.toString()}");
  }
}

Future<String?> signInWithGoogleWeb() async {
  // Initialize Firebase
  await Firebase.initializeApp();
  User? user;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // The `GoogleAuthProvider` can only be used while running on the web
  GoogleAuthProvider authProvider = GoogleAuthProvider();

  try {
    final UserCredential userCredential =
        await _auth.signInWithPopup(authProvider);

    user = userCredential.user;
  } catch (e) {
    print(e);
  }

  return user?.uid;
}

void signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Sign Out");
}
