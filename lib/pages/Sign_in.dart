import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'CustomButton.dart';
import 'CustomTextField.dart';
import 'Sign_up.dart';
import 'home_page.dart';
import 'package:icons_plus/icons_plus.dart';


class SignInScreen extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  final GoogleSignIn _googleSignIn = GoogleSignIn();


  Future<UserCredential> signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final userCredential = await _auth.signInWithCredential(credential);

    // Navigate to the main page after a successful sign-in
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => HomePage()),
    );

    return userCredential;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // Add this
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.lightBlueAccent, Colors.white70],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Login',
                    style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                  SizedBox(height: 50.0),
                  CustomTextField(
                    labelText: 'Email',
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email = value; // Store the email value
                    },
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    labelText: 'Password',
                    prefixIcon: Icons.lock_outline,
                    obscureText: true,
                    onChanged: (value) {
                      password = value; // Store the password value
                    },
                  ),
                  SizedBox(height: 30),
                  CustomButton(
                    onPressed: () async {
                      try {
                        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        print(userCredential.user!.uid); // This is the user ID
                        if (userCredential.user != null) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    text: 'LOGIN',
                  ),
                  SizedBox(height: 20), // Add space between the buttons
                  Text('Or Sign Up Using'),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Bootstrap.google, size: 36.0, color: Colors.blue),
                        onPressed: () async {
                          try {
                            final user = await signInWithGoogle(context);
                            print('Signed in with Google: ${user.user?.displayName}');
                          } catch (e) {
                            print(e);
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  CustomButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegistrationForm()),
                      );
                    },
                    text: 'SIGN UP',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
