import 'package:cricket_users_app/services/auth.dart';
import 'package:cricket_users_app/shared/loading.dart';
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

  bool _loading = false;

  // text field state
  String _email = '';
  String _password = '';
  String _error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color(0xdd4c8c50),
          title: Text('Sign Up'),
          actions: <Widget>[
            ElevatedButton.icon(
              icon: Icon(Icons.person),
              label: Text('Sign in'),
              onPressed: () {
                widget.toggleView();
              },
              style: ElevatedButton.styleFrom(
                  primary: Color(0x570d0600),
                  //border width and color
                  elevation: 3,
                  //elevation of button
                  padding: EdgeInsets.all(20) //content padding inside button
                  ),
            )
          ],
        ),
        body: _loading
            ? Loading()
            : Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('background.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.7), BlendMode.dstATop),
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                  margin: EdgeInsets.symmetric(vertical: 100),
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
                        SizedBox(
                          // height: 100, //height of button
                          width: 390, //width of button
                          child: ElevatedButton(
                            child: Text('Register'),
                            style: ElevatedButton.styleFrom(
                                primary: Color(0x570d0600),
                                elevation: 3,
                                //elevation of button
                                padding: EdgeInsets.all(
                                    20) //content padding inside button
                                ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() => _loading = true);

                                dynamic result = await _authService.register(
                                    _email, _password);

                                if (result == null) {
                                  setState(() {
                                    _loading = false;
                                    _error = 'Invalid Email or Password!';
                                  });
                                }
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        SizedBox(
                          // height: 100, //height of button
                          width: 390, //width of button
                          child: ElevatedButton(
                            child: Text('Login as Anonymous'),
                            style: ElevatedButton.styleFrom(
                                primary: Color(0x572984AD),
                                elevation: 3,
                                //elevation of button
                                padding: EdgeInsets.all(
                                    20) //content padding inside button
                                ),
                            onPressed: () async {
                              setState(() => _loading = true);
                              dynamic result =
                                  await _authService.signInAnonymously();

                              if (result == null) {
                                setState(() {
                                  _loading = false;
                                  _error = 'Sorry! Error Occurred!';
                                });
                              }
                            },
                          ),
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
                ),
              ));
  }
}
