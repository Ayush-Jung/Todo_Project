import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/model/task.dart';

class CloudDatabase {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('data');
  addData(Task task) async {
    await collectionReference.doc(task.id).set(task.toMap());
  }

  Stream<QuerySnapshot> fetchData() {
    var data = collectionReference.snapshots();
    return data;
  }

  updateData(String id, String title, String desc) async {
    await collectionReference.doc(id).update({
      'title': title,
      'description': desc,
    });
  }

  deleteData() async {
    QuerySnapshot querySnapshot = await collectionReference.get();
    querySnapshot.docs[0].reference.delete();
  }
}
