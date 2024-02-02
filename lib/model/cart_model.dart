import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  // list of items on sale
  final List _shopItems = const [
    // [ itemName, itemPrice, imagePath, color ]
    ["Avocado", "4.00", "lib/images/avocado.png", Colors.green],
    ["Banana", "2.50", "lib/images/banana.png", Colors.yellow],
    ["Chicken", "12.80", "lib/images/chicken.png", Colors.brown],
    ["Water", "1.00", "lib/images/water.png", Colors.blue],
    ["Dragon Fruit", "3.00", "lib/images/dragon-fruit.png", Colors.red],
    ["Apple", "2.00", "lib/images/apple.png", Colors.green],
    ["Butter", "5.00", "lib/images/butter.png", Colors.blue],
    ["Cabbage", "1.50", "lib/images/cabbage.png", Colors.lightGreen],
    ["Carrot", "2.00", "lib/images/carrot.png", Colors.orange],
    ["Cheese", "1.70", "lib/images/cheese.png", Colors.yellow],
    ["Cupcake", "3.00", "lib/images/cupcake.png", Colors.pink],
    ["Lemon", "2.00", "lib/images/lemon.png", Colors.yellowAccent],
    ["Meat 1kg", "5.00", "lib/images/meat.png", Colors.redAccent],
  ];

  // list of cart items
  List _cartItems = [];

  get cartItems => _cartItems;

  get shopItems => _shopItems;

  // add item to cart
  void addItemToCart(int index) {
    _cartItems.add(_shopItems[index]);
    notifyListeners();
  }

  // remove item from cart
  void removeItemFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  // calculate total price
  String calculateTotal() {
    double totalPrice = 0;
    for (int i = 0; i < cartItems.length; i++) {
      totalPrice += double.parse(cartItems[i][1]);
    }
    return totalPrice.toStringAsFixed(2);
  }
}
