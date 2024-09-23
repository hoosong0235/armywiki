import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthController {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static FirebaseFirestore db = FirebaseFirestore.instance;

  static bool get emailVerified => firebaseAuth.currentUser!.emailVerified;

  static Future<void> sendEmailVerification() async {
    await firebaseAuth.currentUser!.sendEmailVerification();
  }

  static Future<void> reload() async {
    await firebaseAuth.currentUser!.reload();
  }

  static Future<bool> register(
    String name,
    String email,
    String password,
    Timestamp enlist,
    String unitId,
  ) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = <String, dynamic>{
        "name": name,
        "email": email,
        "password": password,
        "enlist": enlist,
        "unit_id": unitId,
        "unit_ids": [],
      };

      db
          .collection(
            "users",
          )
          .doc(
            credential.user?.uid,
          )
          .set(
            user,
          )
          .onError(
            (e, _) {},
          );

      await sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
      } else if (e.code == 'email-already-in-use') {}

      return false;
    } catch (e) {
      return false;
    }

    return true;
  }

  static Future<bool> login(
    String email,
    String password,
  ) async {
    try {
      // ignore: unused_local_variable
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
      } else if (e.code == 'wrong-password') {}

      return false;
    } catch (e) {
      return false;
    }

    return true;
  }

  static Future<bool> logout() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      return false;
    }

    return true;
  }
}
