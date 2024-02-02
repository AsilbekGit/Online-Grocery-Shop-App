import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DeliveryPage extends StatelessWidget {
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
              subtitle: Text('Track your order on the map'),
            ),
            Container(
              height: 300,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(0, 0), // You can use user's location here
                  zoom: 14.4746,
                ),
              ),
            ),
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
