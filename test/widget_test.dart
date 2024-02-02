import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/model/cart_model.dart';

import 'package:project/pages/CustomButton.dart';
import 'package:project/pages/CustomTextField.dart';
import 'package:project/pages/Sign_in.dart';
import 'package:project/pages/Sign_up.dart';
import 'package:project/pages/my_profile.dart';
import 'package:project/pages/paymentPage.dart';

import 'package:provider/provider.dart';
void main() {
  group('App Widget Tests', () {
    // Test for CustomButton
    testWidgets('CustomButton displays text and responds to tap', (WidgetTester tester) async {
      bool buttonPressed = false;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: CustomButton(
            onPressed: () {
              buttonPressed = true;
            },
            text: 'Tap Me',
            color: Colors.red,
            textColor: Colors.white,
          ),
        ),
      ));

      expect(find.text('Tap Me'), findsOneWidget);

      await tester.tap(find.byType(CustomButton));
      await tester.pump();

      expect(buttonPressed, true);
    });

    // Test for CustomTextField
    testWidgets('CustomTextField updates and displays text', (WidgetTester tester) async {
      String textFieldInput = '';

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: CustomTextField(
            labelText: 'Enter Text',
            prefixIcon: Icons.person,
            onChanged: (value) {
              textFieldInput = value;
            },
          ),
        ),
      ));

      const String testInput = 'Test Input';

      expect(find.byType(CustomTextField), findsOneWidget);

      await tester.enterText(find.byType(CustomTextField), testInput);
      await tester.pump();

      expect(textFieldInput, equals(testInput));
    });

    // Test for Profile Update on EditProfilePage
    testWidgets('EditProfilePage allows profile updates', (WidgetTester tester) async {
      // Assuming we're using a Mock for FirebaseAuth and FirebaseFirestore
      final MockFirebaseAuth mockAuth = MockFirebaseAuth();
      final MockFirebaseFirestore mockFirestore = MockFirebaseFirestore();

      // Initialize Firebase
      await Firebase.initializeApp();

      // Populate initial mock data
      // You need to replace this with actual mock setup code
      when(mockFirestore.collection('users').doc(any)).thenReturn(/* Mock Document Reference */);

      await tester.pumpWidget(MaterialApp(
        home: EditProfilePage(userId: 'testUser'),
      ));

      // Populate fields with test data
      await tester.enterText(find.byType(TextField).at(0), 'New Name');
      await tester.enterText(find.byType(TextField).at(1), 'newemail@test.com');
      await tester.enterText(find.byType(TextField).at(2), '1234567890');
      await tester.enterText(find.byType(TextField).at(3), 'New Address');

      // Tap the save button
      await tester.tap(find.text('Save Changes'));
      await tester.pumpAndSettle();

      // Assuming update is successful, verify if a Snackbar appears or check for any UI changes
      // This part of the test might need to be adjusted based on actual app behavior
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Profile updated successfully'), findsOneWidget);
    });
  });
  testWidgets('Navigating to PaymentPage displays the page', (WidgetTester tester) async {
    // Create a mock CartModel or use a real instance if appropriate
    final mockCartModel = CartModel();

    // Define a test app widget
    Widget testWidget = MaterialApp(
      home: Scaffold(
        body: Provider<CartModel>(
          create: (context) => mockCartModel,
          child: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentPage()),
                );
              },
              child: Text('Go to Payment'),
            ),
          ),
        ),
      ),
    );

    // Build our app and trigger a frame
    await tester.pumpWidget(testWidget);

    // Tap the button to navigate to PaymentPage
    await tester.tap(find.text('Go to Payment'));
    await tester.pumpAndSettle(); // Wait for the navigation to complete

    // Verify that PaymentPage is displayed
    expect(find.byType(PaymentPage), findsOneWidget);
    expect(find.text('Secure Payment'), findsOneWidget); // Checking for AppBar title
  });
  testWidgets('Navigating from RegistrationForm to SignInScreen after successful registration', (WidgetTester tester) async {
    // Wrap RegistrationForm in a MaterialApp to enable navigation.
    await tester.pumpWidget(
        MaterialApp(
      home: RegistrationForm(),
      routes: {
        '/signInScreen': (context) => SignInScreen(), // Define the route for navigation
      },
    ));

    // Simulate user input in the registration form fields...
    await tester.enterText(find.byType(TextFormField).at(0), 'Test Name');
    await tester.enterText(find.byType(TextFormField).at(1), 'test@example.com');
    // Continue for other fields as necessary...

    // Find the submit button and tap it. Adjust the finder if your button doesn't use text or needs a more specific finder.
    await tester.tap(find.text('Submit'));
    await tester.pumpAndSettle(); // Wait for animations and futures to complete.

    // Verify that after tapping submit, we navigate to the SignInScreen.
    expect(find.byType(SignInScreen), findsOneWidget);
  });
}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}
