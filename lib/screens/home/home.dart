import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cricket_users_app/screens/player/view.dart';
import 'package:cricket_users_app/services/auth.dart';
import 'package:cricket_users_app/services/database.dart';
import 'package:cricket_users_app/shared/loading.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final AuthService _authService = AuthService();
  final DatabaseService _databaseService = DatabaseService();

  var imageArray = [
    'chaminda_vaas.jpg',
    'kumar_sangakkara.jpg',
    'lasith_malinga.jpg',
    'mahela_jayawardene.jpg',
    'muttiah_muralitharan.jpg',
    'sanath_jayasuriya.jpg',
  ];
  var count = 0;

  String randomImage() {
    if (count < 5) {
      count++;
      return imageArray[count];
    } else {
      count = 0;
      return imageArray[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xdd4c8c50),
        title: Text('Cricket App'),
        actions: <Widget>[
          ElevatedButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign out'),
            onPressed: () async {
              await _authService.signOut();
            },
            style: ElevatedButton.styleFrom(
                primary: Color(0x570d0600),
                //border width and color
                elevation: 3,
                //elevation of button
                padding: EdgeInsets.all(20) //content padding inside button
                ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _databaseService.players,
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.data != null) {
            return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('background.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Center(
                          child: Card(
                        margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            ListTile(
                              leading: CircleAvatar(
                                radius: 40.0,
                                backgroundImage: AssetImage(randomImage()),
                                backgroundColor: Colors.transparent,
                              ),
                              title: Text(
                                  streamSnapshot.data!.docs[index]['name']),
                              subtitle: Text(
                                  streamSnapshot.data!.docs[index]['country']),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  margin:
                                      EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                                  child: TextButton(
                                      child: Text(
                                        'View Details',
                                        style:
                                            TextStyle(color: Color(0x990d0600)),
                                      ),
                                      onPressed: () => {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ViewPlayer(
                                                  id: streamSnapshot
                                                      .data!.docs[index].id,
                                                  bio: streamSnapshot
                                                      .data!.docs[index]['bio'],
                                                  name: streamSnapshot.data!
                                                      .docs[index]['name'],
                                                  age: streamSnapshot
                                                      .data!.docs[index]['age'],
                                                  country: streamSnapshot.data!
                                                      .docs[index]['country'],
                                                  runs: streamSnapshot.data!
                                                      .docs[index]['runs'],
                                                ),
                                              ),
                                            )
                                            // _databaseService.deletePlayer(
                                            //     streamSnapshot.data!.docs[index].id);
                                          }),
                                ),
                                const SizedBox(width: 2),
                              ],
                            ),
                          ],
                        ),
                      ));
                    }));
          } else {
            return Loading();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Color(0xdd81101f),
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
      ),
    );
  }
}
