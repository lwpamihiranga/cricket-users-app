import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference playerCollection =
      FirebaseFirestore.instance.collection('players');

  Future updateData(String name, String age) async {
    return await playerCollection.doc(uid).set({'name': name, 'age': age});
  }

  // get player stream
  Stream<QuerySnapshot> get players {
    return playerCollection.snapshots();
  }
}
