import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class FirebaseServices {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        await _auth.signInWithCredential(authCredential);
        FirebaseAuth fAuth = FirebaseAuth.instance;
        final User? firebaseUser = (await fAuth
                .signInWithCredential(authCredential)
                .catchError((msg) {}))
            .user;
        if (firebaseUser != null) {
          String token = await firebaseUser.getIdToken();
          print('Get token from firebase: $token');
          await sendTokenToApi(token);
        }
        print(googleSignInAuthentication.idToken);
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  Future<void> sendTokenToApi(String token) async {
    final url = "https://event-project.herokuapp.com/api/login";
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = json.encode({'token': token, 'role': 'member'});
    final response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    final responseData = json.decode(response.body);
    print('response data: $responseData');
  }

  signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
