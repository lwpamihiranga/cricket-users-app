import 'package:cricket_users_app/services/database.dart';
import 'package:cricket_users_app/shared/loading.dart';
import 'package:flutter/material.dart';

class AddPlayer extends StatefulWidget {
  const AddPlayer({Key? key}) : super(key: key);

  @override
  _AddPlayerState createState() => _AddPlayerState();
}

class _AddPlayerState extends State<AddPlayer> {
  // form key
  final _formKey = GlobalKey<FormState>();

  final DatabaseService _databaseService = DatabaseService();

  bool _loading = false;

  String _bio = '';
  String _name = '';
  String _age = '';
  String _country = '';
  String _runs = '';

  Widget _buildBio() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Bio'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter a bio';
        }
        return null;
      },
      onChanged: (String value) {
        setState(() => _bio = value);
      },
    );
  }

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter a name';
        }
        return null;
      },
      onChanged: (String value) {
        setState(() => _name = value);
      },
    );
  }

  Widget _buildAge() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Age'),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter an age';
        }
        return null;
      },
      onChanged: (String value) {
        setState(() => _age = value);
      },
    );
  }

  Widget _buildCountry() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Country'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter a country';
        }
        return null;
      },
      onChanged: (String value) {
        setState(() => _country = value);
      },
    );
  }

  Widget _buildRuns() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Runs'),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter runs';
        }
        return null;
      },
      onChanged: (String value) {
        setState(() => _runs = value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Player'),
      ),
      body: _loading
          ? Loading()
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 100, horizontal: 50),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      _buildBio(),
                      SizedBox(
                        height: 12.0,
                      ),
                      _buildName(),
                      SizedBox(
                        height: 12.0,
                      ),
                      _buildAge(),
                      SizedBox(
                        height: 12.0,
                      ),
                      _buildCountry(),
                      SizedBox(
                        height: 12.0,
                      ),
                      _buildRuns(),
                      SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                        child: Text('Add Player'),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => _loading = true);

                            dynamic result = await _databaseService.addPlayer(
                                _bio, _name, _age, _country, _runs);

                            if (result == null) {
                              setState(() => _loading = false);
                              Navigator.pop(context);
                            }
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
