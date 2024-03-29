import 'package:cricket_users_app/services/database.dart';
import 'package:cricket_users_app/shared/loading.dart';
import 'package:flutter/material.dart';

class ViewPlayer extends StatefulWidget {
  final String id;
  final String bio;
  final String name;
  final String age;
  final String country;
  final String runs;

  ViewPlayer({
    Key? key,
    required this.id,
    required this.bio,
    required this.name,
    required this.age,
    required this.country,
    required this.runs,
  }) : super(key: key);

  @override
  _ViewPlayerState createState() => _ViewPlayerState();
}

class _ViewPlayerState extends State<ViewPlayer> {
  // form key
  final _formKey = GlobalKey<FormState>();

  bool _loading = false;
  bool _isEdit = false;

  String _appBarTitle = 'View Player';

  String _bio = '';
  String _name = '';
  String _age = '';
  String _country = '';
  String _runs = '';

  Widget _buildBio() {
    return TextFormField(
      enabled: _isEdit,
      initialValue: widget.bio,
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
      onSaved: (String? value) {
        value != null ? _bio = value : '';
      },
    );
  }

  Widget _buildName() {
    return TextFormField(
      enabled: _isEdit,
      initialValue: widget.name,
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
      onSaved: (String? value) {
        value != null ? _name = value : '';
      },
    );
  }

  Widget _buildAge() {
    return TextFormField(
      enabled: _isEdit,
      initialValue: widget.age,
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
      onSaved: (String? value) {
        value != null ? _age = value : '';
      },
    );
  }

  Widget _buildCountry() {
    return TextFormField(
      enabled: _isEdit,
      initialValue: widget.country,
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
      onSaved: (String? value) {
        value != null ? _country = value : '';
      },
    );
  }

  Widget _buildRuns() {
    return TextFormField(
      enabled: _isEdit,
      initialValue: widget.runs,
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
      onSaved: (String? value) {
        value != null ? _runs = value : '';
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final DatabaseService _databaseService = DatabaseService();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0x570d0600),
          title: Text(_appBarTitle),
          actions: <Widget>[
            Visibility(
              visible: !_isEdit,
              child: ElevatedButton.icon(
                icon: Icon(Icons.edit),
                label: Text('Edit'),
                onPressed: () {
                  setState(() {
                    _isEdit = true;
                    _appBarTitle = 'Update Player';
                  });
                },
                style: ElevatedButton.styleFrom(
                    primary: Color(0x570d0600),
                    //border width and color
                    elevation: 3,
                    //elevation of button
                    padding: EdgeInsets.all(20) //content padding inside button
                    ),
              ),
            ),
            Visibility(
              visible: _isEdit,
              child: ElevatedButton.icon(
                icon: Icon(Icons.cancel),
                label: Text('Cancel'),
                onPressed: () {
                  setState(() {
                    _isEdit = false;
                    _appBarTitle = 'View Player';
                  });
                },
                style: ElevatedButton.styleFrom(
                    primary: Color(0x570d0600),
                    //border width and color
                    elevation: 3,
                    //elevation of button
                    padding: EdgeInsets.all(20) //content padding inside button
                    ),
              ),
            ),
          ],
        ),
        body: _loading
            ? Loading()
            : Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('background.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 100, horizontal: 50),
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
                            height: 120.0,
                          ),
                          Visibility(
                            visible: _isEdit,
                            child: ElevatedButton(
                              child: Text('Update Player'),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() => _loading = true);

                                  _formKey.currentState!.save();

                                  dynamic result =
                                      await _databaseService.updatePlayer(
                                          widget.id,
                                          _bio,
                                          _name,
                                          _age,
                                          _country,
                                          _runs);

                                  setState(() => _loading = false);
                                  Navigator.pop(context);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue,
                                elevation: 3,
                                padding: EdgeInsets.all(15),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: !_isEdit,
                            child: ElevatedButton(
                              child: Text('Delete Player'),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() => _loading = true);

                                  dynamic result = await _databaseService
                                      .deletePlayer(widget.id);

                                  if (result == null) {
                                    setState(() => _loading = false);
                                    Navigator.pop(context);
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                                elevation: 3,
                                padding: EdgeInsets.all(15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
  }
}
