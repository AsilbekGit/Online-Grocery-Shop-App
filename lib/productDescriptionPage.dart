import 'package:flutter/material.dart';

class ProductDescriptionPage extends StatefulWidget {
  @override
  _ProductDescriptionPageState createState() => _ProductDescriptionPageState();
}

class _ProductDescriptionPageState extends State<ProductDescriptionPage> {
  int _counter = 0;
  bool _isFavorite = false;
  double _rating = 4.5;
  int _orders = 100;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    if (_counter > 0) {
      setState(() {
        _counter--;
      });
    }
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Description'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Image.network('https://m.media-amazon.com/images/W/MEDIAX_792452-T2/images/I/71Ksr+YG5sL._AC_UF1000,1000_QL80_.jpg', fit: BoxFit.fitWidth),
            ),
            SizedBox(height: 10),
            Text(
              'Ferrero Rocher Premium Choclates 24 Pieces, 300 g',
              style: TextStyle(fontSize: 16.0, color: Colors.blue),
            ),
            Text(
              'Brand\tFerrero Rocher\nItem Form\tBall\nOccasion\tChristmas, Congratulations, Birthday\nChocolate Type\tMilk\nFlavor\tChocolate Hazelnut',
              style: TextStyle(color: Colors.grey),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Rating: $_rating',
                  style: TextStyle(color: Colors.yellow),
                ),
                Text(
                  'Orders Today: $_orders',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: _decrementCounter,
                  color: Colors.red,
                ),
                Text(
                  '$_counter ',
                  style: Theme.of(context).textTheme.headline4,
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _incrementCounter,
                  color: Colors.green,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border),
                  onPressed: _toggleFavorite,
                  color: Colors.pink,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Add to Cart', style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(primary: Colors.purple),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
