import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthController {
  static FirebaseFirestore db = FirebaseFirestore.instance;

  static Future<bool> register(
    String name,
    String email,
    String password,
    Timestamp enlist,
    String unitId,
  ) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = <String, dynamic>{
        "name": name,
        "email": email,
        "password": password,
        "enlist": enlist,
        "unit_id": unitId,
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
            (e, _) => print(
              "Error writing document: $e",
            ),
          );
      ;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print(
          'The password provided is too weak.',
        );
      } else if (e.code == 'email-already-in-use') {
        print(
          'The account already exists for that email.',
        );
      }

      return false;
    } catch (e) {
      print(
        e,
      );

      return false;
    }

    return true;
  }

  static Future<bool> login(
    String email,
    String password,
  ) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print(
          'No user found for that email.',
        );
      } else if (e.code == 'wrong-password') {
        print(
          'Wrong password provided for that user.',
        );
      }

      return false;
    } catch (e) {
      print(
        e,
      );

      return false;
    }

    return true;
  }

  static Future<bool> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(
        e,
      );

      return false;
    }

    return true;
  }
}
