import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPressed = false;


  void whenPressed() {
    setState(() {
      _isPressed = !_isPressed;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Icon(
                    _isPressed ? Icons.account_box_sharp : Icons.lock_outline,
                    size: 100,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Username',
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                    ),
                    SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: whenPressed,
                      child: Text('Login'),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          fixedSize: const Size(300, 50)
                      ),
                    ),
                    SizedBox(height: 50),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            _isPressed ? 'images/insta.png' : 'images/meta1.png',
                            height: 100,
                            width: 100,
                          ),
                          Image.asset(
                            _isPressed ? 'images/meta1.png' : 'images/insta.png',
                            height: 100,
                            width: 100,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
