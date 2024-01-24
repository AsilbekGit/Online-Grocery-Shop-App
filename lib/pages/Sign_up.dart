import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/pages/Sign_in.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _firestore = FirebaseFirestore.instance;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.lightBlueAccent, Colors.white70],
          ),
        ),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2.0),
                        ),
                        prefixIcon: Icon(Icons.person, color: Colors.white70),
                        labelText: 'Full Name',
                        labelStyle: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2.0),
                        ),
                        prefixIcon: Icon(Icons.email, color: Colors.white70),
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2.0),
                        ),
                        prefixIcon: Icon(Icons.home, color: Colors.white70),
                        labelText: 'Address',
                        labelStyle: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2.0),
                        ),
                        prefixIcon: Icon(Icons.phone, color: Colors.white70),
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2.0),
                        ),
                        prefixIcon: Icon(Icons.lock_outline, color: Colors.white70),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.white70),
                      ),
                      obscureText: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2.0),
                        ),
                        prefixIcon: Icon(Icons.lock_outline, color: Colors.white70),
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(color: Colors.white70),
                      ),
                      obscureText: true,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final firestoreInstance = FirebaseFirestore.instance;
                      final auth = FirebaseAuth.instance;
                      try {
                        UserCredential userCredential = await auth.createUserWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                        await firestoreInstance.collection('users').doc(userCredential.user?.uid).set({
                          'fullName': _nameController.text,
                          'email': _emailController.text,
                          'address': _addressController.text,
                          'phoneNumber': _phoneController.text,
                          'password': _passwordController.text,
                          'confirmPassword': _confirmPasswordController.text,
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignInScreen()),
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          print('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          print('The account already exists for that email.');
                        }
                      } catch (e) {
                        print('some thing wrong ');
                      }
                    },
                    child: Text('Submit'),
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
