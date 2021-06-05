import 'package:cricket_users_app/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({Key? key, required this.toggleView}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
        title: Text('Sign Up'),
        actions: <Widget>[
          ElevatedButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign in'),
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
                // validator: (value) => value!.isEmpty ? 'Enter an email' : null,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter an email';
                  }
                  return null;
                },
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
                validator: (value) {
                  if (value!.length < 6) {
                    return 'Password should be at least 6 characters long ';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() => _password = value);
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                child: Text('Register'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    print(_email);
                    print(_password);
                  } else {}
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
