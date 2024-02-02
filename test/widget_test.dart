import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:project/model/cart_model.dart';
import 'package:project/pages/CustomButton.dart';
import 'package:project/pages/CustomTextField.dart';
import 'package:project/pages/DeliveryPage.dart';
import 'package:project/pages/Sign_in.dart';
import 'package:project/pages/paymentPage.dart';
import 'package:project/pages/Sign_up.dart';

void main() {
  group('App Widget Tests', () {
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

    testWidgets('DeliveryPage updates steps and shows completion dialog', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: DeliveryPage()));
      await tester.pump(); // Initial pump to render the UI

      // Simulate timer ticks and check for step completion
      for (int i = 1; i <= 4; i++) {
        await tester.pump(Duration(seconds: 5)); // Simulates timer tick

        // Verify icons are present based on the current step
        // Adjust this part based on your actual implementation
        expect(find.byType(Icon), findsNWidgets(i)); // Example check, adjust accordingly
      }

      // Verify completion dialog is shown
      await tester.pumpAndSettle(); // Wait for animations to complete
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Delivery Complete'), findsOneWidget);

      // Close the dialog
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle(); // Wait for dialog to close
    });

    testWidgets('Navigating to PaymentPage displays the page', (WidgetTester tester) async {
      final mockCartModel = CartModel();

      Widget testWidget = MaterialApp(
        home: Provider<CartModel>(
          create: (_) => mockCartModel,
          child: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => PaymentPage()));
              },
              child: Text('Go to Payment'),
            ),
          ),
        ),
      );

      await tester.pumpWidget(testWidget);
      await tester.tap(find.text('Go to Payment'));
      await tester.pumpAndSettle();

      expect(find.byType(PaymentPage), findsOneWidget);
    });

    testWidgets('Navigating from RegistrationForm to SignInScreen after successful registration', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: RegistrationForm(),
        routes: {
          '/signInScreen': (_) => SignInScreen(),
        },
      ));

      await tester.enterText(find.byType(TextFormField).at(0), 'Test Name');
      await tester.enterText(find.byType(TextFormField).at(1), 'test@example.com');
  // Fill in other fields as needed


      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();

      expect(find.byType(SignInScreen), findsOneWidget);
    });
  });
}
