import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Google Sign In
  signInWithGoogle() async {
    // Begin the process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    // Obtain details from the request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    // Create new credentials for the user
    final credentials = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    // Sign in
    return await FirebaseAuth.instance.signInWithCredential(credentials);
  }
}
