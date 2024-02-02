import 'dart:async';
import 'package:flutter/material.dart';

class DeliveryPage extends StatefulWidget {
  @override
  _DeliveryPageState createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  int currentStep = 0; // You can update this value based on the actual progress
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        if (currentStep < 4) {
          currentStep++;
        } else {
          timer.cancel();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Delivery Complete'),
                content: Text('You can now take your order!'),
                actions: <Widget>[
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delivery Page'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.local_shipping, color: Colors.blue, size: 50),
              title: Text('Your order is on the way!', style: TextStyle(fontSize: 24.0)),
              subtitle: Text('Track your order progress'),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(Icons.check_circle, color: currentStep > 0 ? Colors.green : Colors.grey, size: 50),
                Icon(Icons.shopping_basket, color: currentStep > 1 ? Colors.green : Colors.grey, size: 50),
                Icon(Icons.directions_car, color: currentStep > 2 ? Colors.green : Colors.grey, size: 50),
                Icon(Icons.rate_review, color: currentStep > 3 ? Colors.green : Colors.grey, size: 50),
              ],
            ),
            SizedBox(height: 20.0),
            ListTile(
              leading: Icon(Icons.location_on, color: Colors.blue, size: 50),
              title: Text('Estimated delivery time:', style: TextStyle(fontSize: 20.0)),
              subtitle: Text('30-45 minutes'), // You can use actual estimated time here
            ),
          ],
        ),
      ),
    );
  }
}
