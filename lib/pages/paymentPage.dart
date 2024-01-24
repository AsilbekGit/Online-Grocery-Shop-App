import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/cart_model.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String cardNumber = '';
  bool _isSwitched = false;

  @override
  Widget build(BuildContext context) {
    final cartModel = Provider.of<CartModel>(context);
    final total = cartModel.calculateTotal();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Secure Payment', style: TextStyle(color: Colors.black)),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Text('Secure Checkout', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Icon(Icons.credit_card, color: Colors.black),
                  title: TextField(
                    decoration: InputDecoration(
                      labelText: 'Enter Card Number',
                      labelStyle: TextStyle(color: Colors.black),
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        cardNumber = value;
                      });
                    },
                  ),
                  trailing: Text('Total: \$' + total.toString(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
                ),
              ),
              SwitchListTile(
                title: Text("Remember this card", style: TextStyle(color: Colors.black)),
                subtitle: Text("By selecting this, you agree to the terms of card information storage.", style: TextStyle(color: Colors.black)),
                value: _isSwitched,
                onChanged: (value) {
                  setState(() {
                    _isSwitched = value;
                  });
                },
                activeColor: Colors.green,
              ),
              Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.payment, color: Colors.white),
                    SizedBox(width: 10),
                    Text('Proceed to Pay'),
                    SizedBox(width: 10),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
