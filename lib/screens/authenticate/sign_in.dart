import 'package:cricket_users_app/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({Key? key, required this.toggleView}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // get AuthService instance
  final AuthService _authService = AuthService();
  // form key
  final _formKey = GlobalKey<FormState>();

  // text field state
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.brown[100],
      appBar: AppBar(
        // backgroundColor: Colors.brown[400],
        // elevation: 0.0,
        title: Text('Sign In'),
        actions: <Widget>[
          ElevatedButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: (value) {
                  setState(() => _email = value);
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                onChanged: (value) {
                  setState(() => _password = value);
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                child: Text('Sign in'),
                onPressed: () async {
                  print(_email);
                  print(_password);
                },
              )
            ],
          ),
        ),

        // Old anonymous sign in button
        // ElevatedButton(
        //   child: Text('Sign In Anonymously'),
        //   onPressed: () async {
        //     dynamic result = await _authService.signInAnonymously();
        //
        //     if (result == null) {
        //       print('Error Signing In');
        //     } else {
        //       print('Signed In');
        //       print(result.uid);
        //     }
        //   },
        // ),
      ),
    );
  }
}
