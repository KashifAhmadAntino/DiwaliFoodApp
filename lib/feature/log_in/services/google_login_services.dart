import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthentication {
  static final GoogleAuthentication _instance =
      GoogleAuthentication._internal();

  factory GoogleAuthentication() {
    return _instance;
  }

  var _googleSignIn;

  GoogleAuthentication._internal() {
    _googleSignIn = GoogleSignIn();
  }

  Future<GoogleSignInAccount?> signIn() async {
    return await _googleSignIn.signIn();
  }

  Future<GoogleSignInAccount?> signOut() async {
    return await _googleSignIn.disconnect();
  }
}
