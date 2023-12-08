import 'package:flutter/foundation.dart';

class User_Model {
  final String name;
  final String email;
  final String phoneNumber;
  final String address;

  const User_Model({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
  });
}

class User_List {
  List<User_Model> _user_list = const [
    User_Model(
        name: 'Sanjar Totliboyev',
        email: 'sanjar@gmail.com',
        phoneNumber: '+998991234567',
        address: 'Tashkent, Mirzo Ulugbek 3')
  ];

  User_Model current_user;

  User_List({
    required this.current_user,
  });

  User_Model get get_current_user => current_user;

  set set_current_user(User_Model user_m) {
    current_user = user_m;
  }
}
