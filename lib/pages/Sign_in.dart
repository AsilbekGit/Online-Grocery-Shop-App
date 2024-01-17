import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/pages/home_page.dart';

import 'CustomButton.dart';
import 'CustomTextField.dart';
import 'Sign_up.dart';


class SignInScreen extends StatelessWidget {
  final _auth = FirebaseAuth.instance; // Initialize FirebaseAuth
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                      final user = await _auth.signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      if (user != null) {
                        Navigator.push(
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
                    Icon(Icons.facebook, size: 36.0, color: Colors.blue),
                    Icon(Icons.air, size: 36.0, color: Colors.blue),
                    Icon(Icons.g_translate, size: 36.0, color: Colors.blue),
                  ],
                ),
                SizedBox(height: 50),
                CustomButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  },
                  text: 'SIGN UP',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
