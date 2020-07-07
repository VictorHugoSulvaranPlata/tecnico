import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  var firebaseAuth = FirebaseAuth.instance;
  var loggedIn = false;

  Future initiateSignIn(String type) async {
    await _handleSignIn(type).then((result) {
      if (result == 1) {
        print('soy TRUE');
        loggedIn = true;
        Get.toNamed('home');
      } else {
        loggedIn = false;
      }
      return loggedIn;
    });
  }

  Future logOut() async {
    try {
      print('AMONOSSSSS');
      return await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
    // FacebookLogin().logOut();
    // GoogleSignIn().signOut();
  }

  Future<int> _handleSignIn(String type) async {
    switch (type) {
      case "FB":
        FacebookLoginResult facebookLoginResult = await _handleFBSignIn();
        final accessToken = facebookLoginResult.accessToken.token;
        if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
          final facebookAuthCred =
              FacebookAuthProvider.getCredential(accessToken: accessToken);
          final user =
              await firebaseAuth.signInWithCredential(facebookAuthCred);
          print("User : " + user.user.displayName);
          print("mail : " + user.user.email);
          print("User : " + user.user.uid);
          return 1;
        } else
          return 0;
        break;
      case "G":
        try {
          GoogleSignInAccount googleSignInAccount = await _handleGoogleSignIn();
          final googleAuth = await googleSignInAccount.authentication;
          final googleAuthCred = GoogleAuthProvider.getCredential(
              idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
          final user = await firebaseAuth.signInWithCredential(googleAuthCred);
          print("User : " + user.user.displayName);
          print("mail : " + user.user.email);
          print("User : " + user.user.uid);

          return 1;
        } catch (error) {
          return 0;
        }
    }
    return 0;
  }

  Future<FacebookLoginResult> _handleFBSignIn() async {
    FacebookLogin facebookLogin = FacebookLogin();
    FacebookLoginResult facebookLoginResult =
        await facebookLogin.logIn(['email']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.cancelledByUser:
        print("Cancelled");
        break;
      case FacebookLoginStatus.error:
        print("error");
        break;
      case FacebookLoginStatus.loggedIn:
        print("Logged In");
        break;
    }
    return facebookLoginResult;
  }

  Future<GoogleSignInAccount> _handleGoogleSignIn() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email', 'https://www.googleapis.com/auth/contacts.readonly']);
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    return googleSignInAccount;
  }
}
