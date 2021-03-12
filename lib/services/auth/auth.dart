import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SmsAuth {
  String _phoneNum;
  String _codeNum;
  BuildContext context;
  String _verificationId;

  AnimationController animationController;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> verifyPhone(Function error, Function success) async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationId = verId;
    };
    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      success();
    };

    final PhoneVerificationCompleted verifiedSuccess =
        (AuthCredential user) async {
      success();
    };
    final PhoneVerificationFailed verifyFailed =
        (AuthException exception) async {
      print(exception.message);
      error();
    };
    print(phoneNum);
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: this.phoneNum,
        codeAutoRetrievalTimeout: autoRetrieve,
        timeout: Duration(seconds: 5),
        codeSent: smsCodeSent,
        verificationCompleted: verifiedSuccess,
        verificationFailed: verifyFailed);
  }

  Future<bool> signInWithPhoneNumber() async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: _verificationId,
      smsCode: codeNum,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    FirebaseUser user = authResult.user; 
    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    if (currentUser == null) return false;
    return true;
  }

  String get phoneNum => _phoneNum;

  set phoneNum(String phoneNum) {
    _phoneNum = phoneNum;
  }

  String get codeNum => _codeNum;

  set codeNum(String codeNum) {
    _codeNum = codeNum;
  }

  String get verificationId => _verificationId;

  set verificationId(String verificationId) {
    _verificationId = verificationId;
  }
}
