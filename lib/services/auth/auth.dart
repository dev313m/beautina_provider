import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SmsAuth {
  String? phoneNum;
   late String codeNum;
  BuildContext? context;
   late String verificationId;

  AnimationController? animationController;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> verifyPhone(Function error, Function success) async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationId = verId;
    };
    final PhoneCodeSent smsCodeSent = (String verId, [int? forceCodeResend]) {
      this.verificationId = verId;
      success();
    };

    final PhoneVerificationCompleted verifiedSuccess =
        (AuthCredential user) async {
      success();
    };
    final PhoneVerificationFailed verifyFailed =
        (exception) async {
      print(exception.message);
      error();
    };
    print(phoneNum);
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: this.phoneNum!,
        codeAutoRetrievalTimeout: autoRetrieve,
        timeout: Duration(seconds: 5),
        codeSent: smsCodeSent,
        verificationCompleted: verifiedSuccess,
        verificationFailed: verifyFailed);
  }

  Future<bool> signInWithPhoneNumber() async {
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: codeNum,
    );

    final UserCredential authResult = await _auth.signInWithCredential(credential);
    User user = authResult.user!; 
    final User currentUser =  _auth.currentUser!;
    assert(user.uid == currentUser.uid);

    if (currentUser == null) return false;
    return true;
  }


}
