// begin the interactive sign in process
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // sign-in with google
  signInWithGoogle() async {
    // begin sign in process
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // obtain auth details from request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // sign in with credential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
