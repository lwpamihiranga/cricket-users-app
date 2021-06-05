import 'package:cricket_users_app/services/auth.dart';
import 'package:cricket_users_app/shared/loading.dart';
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

  bool _loading = false;

  // text field state
  String _email = '';
  String _password = '';
  String _error = '';

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
      body: _loading
          ? Loading()
          : Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Email', labelText: 'Email'),
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
                      decoration: InputDecoration(
                          hintText: 'Password', labelText: 'Password'),
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
                      child: Text('Sign in'),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() => _loading = true);

                          dynamic result =
                              await _authService.signIn(_email, _password);

                          if (result == null) {
                            setState(() {
                              _loading = false;
                              _error = 'Invalid Email or Password!';
                            });
                          }
                        }
                      },
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      _error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
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
