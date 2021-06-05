import 'package:cricket_users_app/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('Cricket App'),
        // backgroundColor: Colors.brown[400],
        // elevation: 0.0,
        actions: <Widget>[
          ElevatedButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign out'),
            onPressed: () async {
              await _authService.signOut();
            },
          ),
        ],
      ),
    );
  }
}
