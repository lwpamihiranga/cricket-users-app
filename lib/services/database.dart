import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  // collection reference
  final CollectionReference playerCollection =
      FirebaseFirestore.instance.collection('players');

  Future addPlayer(
      String bio, String name, String age, String country, String runs) async {
    return await playerCollection.doc().set({
      'bio': bio,
      'name': name,
      'age': age,
      'country': country,
      'runs': runs
    });
  }

  Future updatePlayer(String player, String bio, String name, String age,
      String country, String runs) async {
    return await playerCollection.doc(player).update({
      'bio': bio,
      'name': name,
      'age': age,
      'country': country,
      'runs': runs
    });
  }

  Future deletePlayer(String player) async {
    return await playerCollection.doc(player).delete();
  }

  // get player stream
  Stream<QuerySnapshot> get players {
    return playerCollection.snapshots();
  }
}
