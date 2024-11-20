import 'package:cloud_firestore/cloud_firestore.dart';

class CodeShortner {
  static Future<String> storeTheCode(String data, String purpose) async {
    try {
      CollectionReference ref = FirebaseFirestore.instance.collection(purpose);
      String id = DateTime.now().microsecondsSinceEpoch.toString();
      await ref.doc(id).set({id: data}, SetOptions(merge: false));
      return id;
    } catch (e) {
      return "Failed";
    }
  }

  static Future<String> getTheCode(String id, String purpose) async {
    try {
      CollectionReference ref = FirebaseFirestore.instance.collection(purpose);
      DocumentSnapshot snapshot = await ref.doc(id).get();
      String myCode = "Failed";
      if (snapshot.exists) {
        myCode = snapshot.get(id);
        await ref.doc(id).delete();
      }
      return myCode;
    } catch (e) {
      print(e);

      return "Failed";
    }
  }
}
