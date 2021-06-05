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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cricket App'),
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
      body: StreamBuilder(
        stream: _databaseService.players,
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.data != null) {
            return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  // return Text(streamSnapshot.data!.docs[index]['name']);
                  return Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Card(
                      margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 25.0,
                          backgroundColor: Colors.lightBlueAccent,
                        ),
                        title: Column(
                          children: [
                            Row(
                              children: [
                                Text(streamSnapshot.data!.docs[index]['name']),
                              ],
                            ),
                            Row(
                              children: [
                                Text(streamSnapshot.data!.docs[index]
                                    ['country']),
                              ],
                            )
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewPlayer(
                                id: streamSnapshot.data!.docs[index].id,
                                bio: streamSnapshot.data!.docs[index]['bio'],
                                name: streamSnapshot.data!.docs[index]['name'],
                                age: streamSnapshot.data!.docs[index]['age'],
                                country: streamSnapshot.data!.docs[index]
                                    ['country'],
                                runs: streamSnapshot.data!.docs[index]['runs'],
                              ),
                            ),
                          );
                          // _databaseService.deletePlayer(
                          //     streamSnapshot.data!.docs[index].id);
                        },
                      ),
                    ),
                  );
                });
          } else {
            return Loading();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
      ),
    );
  }
}
