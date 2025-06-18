import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies/core/constace.dart';
import 'package:movies/core/models/user_Dm.dart';

abstract class FirebaseService {
  static CollectionReference<UserDm> getUserCollection() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference<UserDm> users = db
        .collection(userCollectionRef)
        .withConverter<UserDm>(
          fromFirestore: (snapshot, options) => UserDm.fromJson(snapshot),
          toFirestore: (user, options) => user.toJson(),
        );
    return users;
  }

  static Future<UserDm> createUserAccount(
    UserDm userDm,
    String password,
  ) async {
    UserCredential credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: userDm.email,
          password: password,
        );
    userDm.userID = credential.user!.uid;
    await addUserToFireStore(userDm);
    UserDm.currentUser = await getUserByDocID(userDm.userID);
    return UserDm.currentUser!;
  }

  static Future<void> addUserToFireStore(UserDm userDm) async {
    CollectionReference<UserDm> users = getUserCollection();
    DocumentReference<UserDm> userDoc = users.doc(userDm.userID);
    await userDoc.set(userDm);
  }

  static Future<UserDm?>? getUserByDocID(String userId) async {
    CollectionReference<UserDm> users = getUserCollection();
    DocumentReference<UserDm> userDoc = users.doc(userId);
    DocumentSnapshot<UserDm> userSnapShot = await userDoc.get();
    return userSnapShot.data();
  }

  static Future<UserDm> loginWithEmail(String email, String password) async {
    UserCredential credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    UserDm.currentUser = await getUserByDocID(credential.user!.uid);
    return UserDm.currentUser!;
  }

  static Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return null;
    final GoogleSignInAuthentication? googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(credential);
    print(userCredential.user!.uid);
    print(getUserByDocID(userCredential.user!.uid));
    if (await getUserByDocID(userCredential.user!.uid) == null) {
      print("________________________");
      await addUserToFireStore(
        UserDm(
          userID: userCredential.user!.uid,
          avatar: avatars[0],
          userName: userCredential.user!.displayName ?? '',
          email: userCredential.user!.email ?? '',
          phoneNumber: userCredential.user!.phoneNumber ?? '',
          watchList: [],
          history: [],
        ),
      );
    }
    UserDm.currentUser = await getUserByDocID(userCredential.user!.uid);
    return userCredential;
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  static Future<void> resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

 static Future<void> deleteAccount(String userID) async {
    CollectionReference<UserDm> user = getUserCollection();
    DocumentReference<UserDm> userDoc = user.doc(userID);
    await userDoc.delete();
    await FirebaseAuth.instance.currentUser!.delete();
    UserDm.currentUser = null;
    await signOut();
  }
}
