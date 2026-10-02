import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_app/feature/data/model/contact_user.dart';

abstract class AppFirebaseService {
  static CollectionReference<ContactUser> collection() {
    return FirebaseFirestore.instance
        .collection("Contact")
        .withConverter<ContactUser>(
          fromFirestore: (snapshot, _) =>
              ContactUser.fromJson(snapshot.data()!),
          toFirestore: (contactUser, _) => contactUser.toJson(),
        );
  }

  static Future<void> addUser(ContactUser user) async {
    var doc = collection().doc();
    user.id = doc.id;
    await doc.set(user);
  }

  static Future<void> delete(String? id) async {
    await collection().doc(id).delete();
  }

  static Future<void> update(ContactUser user) async {
    await collection().doc(user.id).update(user.toJson());
  }

  static Future<List<ContactUser>> getAllData() async {
    var data = await collection().get();
    return data.docs
        .map(
          (e) => ContactUser(
            name: e.data().name,
            phone: e.data().phone,
            id: e.data().id,
          ),
        )
        .toList();
  }
}
