import 'package:armywiki/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CloudFirestoreController {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static FirebaseFirestore db = FirebaseFirestore.instance;

  static UserModel? userModel;

  static bool isFavorite(String unitId) =>
      userModel?.unitIds.contains(unitId) ?? false;

  static Future<UserModel?> getUserNullable() async {
    try {
      var doc = await db
          .collection(
            "users",
          )
          .doc(
            firebaseAuth.currentUser!.uid,
          )
          .get();

      return UserModel.fromDoc(doc.data()!);
    } catch (e) {
      return null;
    }
  }

  static Future<bool> fetchUser() async {
    userModel = await getUserNullable();

    return userModel != null;
  }

  static void addUnit(String unitId) {
    userModel?.unitIds.add(unitId);

    db.collection("users").doc(firebaseAuth.currentUser!.uid).update(
      {
        "unit_ids": FieldValue.arrayUnion(
          [
            unitId,
          ],
        ),
      },
    );
  }

  static void removeUnit(String unitId) {
    userModel?.unitIds.remove(unitId);

    db.collection("users").doc(firebaseAuth.currentUser!.uid).update(
      {
        "unit_ids": FieldValue.arrayRemove(
          [
            unitId,
          ],
        ),
      },
    );
  }
}
