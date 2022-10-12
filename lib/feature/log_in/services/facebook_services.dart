import 'dart:developer';

import 'package:flutter_login_facebook/flutter_login_facebook.dart';

class FacebookAuthentication {
  //add package flutter_login_facebook: ^1.6.0
  static final FacebookAuthentication _instance =
      FacebookAuthentication._internal();
  factory FacebookAuthentication() {
    return _instance;
  }
  late FacebookLogin fb;
  FacebookAuthentication._internal() {
    fb = FacebookLogin();
  }
  Future<Map<String, dynamic>> signIn() async {
    // Log in
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    // Check result status
    switch (res.status) {
      case FacebookLoginStatus.success:
        // Logged in
        // Send access token to server for validation and auth
        final FacebookAccessToken? accessToken = res.accessToken;
        log('Access token: ${accessToken!.token}');
        // Get profile data
        final profile = await fb.getUserProfile();
        log('Hello, ${profile!.name}! You ID: ${profile.userId}');
        // Get user profile image url
        final imageUrl = await fb.getProfileImageUrl(width: 100);
        log('Your profile image: $imageUrl');
        // Get email (since we request email permission)
        final email = await fb.getUserEmail();
        // But user can decline permission
        if (email != null) log('And your email is $email');
        return {
          'status': 'success',
          'message': 'Successfully Signed In',
          'data': {
            'userName': profile.name,
            'userID': profile.userId,
            'profileImage': imageUrl,
            'userEmail': email
          }
        };
      case FacebookLoginStatus.cancel:
        // User cancel log in
        return {'status': 'cancelled', 'message': 'User Cancelled'};
      case FacebookLoginStatus.error:
        // Log in failed
        log('Error while log in: ${res.error}');
        return {
          'status': 'error',
          'message': 'Error while log in: ${res.error}'
        };
      default:
        return {};
    }
  }

  signOut() async {
    await fb.logOut();
  }
}
