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

  Future updatePlayer(String id, String bio, String name, String age,
      String country, String runs) async {
    return await playerCollection.doc(id).update({
      'bio': bio,
      'name': name,
      'age': age,
      'country': country,
      'runs': runs
    });
  }

  Future deletePlayer(String id) async {
    return await playerCollection.doc(id).delete();
  }

  // get player stream
  Stream<QuerySnapshot> get players {
    return playerCollection.snapshots();
  }
}
