import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  final String userId;

  ProfilePage({Key? key, required this.userId}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Page"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              // Navigate to the profile editing screen
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfilePage(userId: widget.userId)),
              );

              // After returning from the EditProfilePage, trigger a rebuild
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              // Call a function to handle logout
              _logout();
            },
          ),
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: _firestore.collection('users').doc(widget.userId).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    title: Text("Name", style: TextStyle(color: Colors.blue)),
                    subtitle: Text("${data['fullName']}", style: TextStyle(fontSize: 18)),
                  ),
                  ListTile(
                    title: Text("Email", style: TextStyle(color: Colors.blue)),
                    subtitle: Text("${data['email']}", style: TextStyle(fontSize: 18)),
                  ),
                  ListTile(
                    title: Text("Phone", style: TextStyle(color: Colors.blue)),
                    subtitle: Text("${data['phoneNumber']}", style: TextStyle(fontSize: 18)),
                  ),
                  ListTile(
                    title: Text("Address", style: TextStyle(color: Colors.blue)),
                    subtitle: Text("${data['address']}", style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            );
          }

          return const CircularProgressIndicator();
        },
      ),
    );
  }

  // Function to handle logout
  void _logout() async {
    try {
      // Sign out the user
      await _auth.signOut();

      // Navigate to the login page (assuming you have a LoginPage)
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      // Handle errors (e.g., display an error message)
      print("Error during logout: $e");
    }
  }
}

class EditProfilePage extends StatefulWidget {
  final String userId;

  EditProfilePage({Key? key, required this.userId}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // Add TextEditingController for each field
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              // Call a function to handle logout
              _logout();
            },
          ),
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(widget.userId).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

            // Populate the text controllers with existing data
            _nameController.text = data['fullName'];
            _emailController.text = data['email'];
            _phoneController.text = data['phoneNumber'];
            _addressController.text = data['address'];

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: "Name"),
                  ),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: "Email"),
                  ),
                  TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(labelText: "Phone"),
                  ),
                  TextField(
                    controller: _addressController,
                    decoration: InputDecoration(labelText: "Address"),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Call a function to update the profile in the database
                      _updateProfile();
                    },
                    child: Text("Save Changes"),
                  ),
                ],
              ),
            );
          }

          return const CircularProgressIndicator();
        },
      ),
    );
  }

  // Function to handle logout
  void _logout() async {
    try {
      // Sign out the user
      await FirebaseAuth.instance.signOut();

      // Navigate to the login page (assuming you have a LoginPage)
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      // Handle errors (e.g., display an error message)
      print("Error during logout: $e");
    }
  }

  // Function to update the profile in the database
  void _updateProfile() async {
    try {
      // Get the updated values from text controllers
      String newName = _nameController.text;
      String newEmail = _emailController.text;
      String newPhone = _phoneController.text;
      String newAddress = _addressController.text;

      // Update the user document in the 'users' collection
      await FirebaseFirestore.instance.collection('users').doc(widget.userId).update({
        'fullName': newName,
        'email': newEmail,
        'phoneNumber': newPhone,
        'address': newAddress,
      });

      // Show a snackbar to indicate successful update
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully')),
      );

      // Navigate back to the previous screen
      Navigator.pop(context);
    } catch (e) {
      // Handle errors (e.g., display an error message)
      print("Error updating profile: $e");

      // Show a snackbar with an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile. Please try again later.')),
      );
    }
  }
}
