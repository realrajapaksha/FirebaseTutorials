import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);


import 'package:firebase_auth/firebase_auth.dart';


Future<void> register() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: "useremail@example.com", password: "userpassword");
      print("user registed." + userCredential.user!.uid);
      setState(() {
        user = userCredential.user!.uid;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        setState(() {
          error = 'The password provided is too weak.';
        });
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        setState(() {
          error = 'The account already exists for that email.';
        });
      }
    } catch (e) {
      print(e);
    }
}

Future<void> signIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: "useremail@example.com", password: "userpassword");
      print("user registed." + userCredential.user!.uid);
      setState(() {
        user = userCredential.user!.uid;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        setState(() {
          error = 'No user found for that email.';
        });
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        setState(() {
          error = 'Wrong password provided for that user.';
        });
      }
    }
}


FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        setState(() {
          isSign = false;
        });
      } else {
        print('User is signed in!');
        setState(() {
          isSign = true;
        });
      }
 });




import 'package:cloud_firestore/cloud_firestore.dart';

var db = FirebaseFirestore.instance;

Insert data
   Future<void> _saveFirestoreData() async {
    final task = <String, dynamic>{
      "id": id,
      "task": _taskNameController.text,
      "description": _taskDesController.text,
      "date": DateTime.now().toString(),
    };

    await db
        .collection("task")
        .doc(id.toString())
        .set(task)
        .whenComplete(() => {
             print("successful")
            });
  }


Future<void> _readFirestoreData() async {
    final docRef = db.collection("cities").doc("SF");
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
      },
      onError: (e) => print("Error getting document: $e"),
    );
}


Future<void> _updateFirestoreData() async {
  final task = <String, dynamic>{
    "id": id,
    "task": _taskNameController.text,
    "description": _taskDesController.text,
    "date": DateTime.now().toString(),
  };

  await db
    .collection("task")
    .doc(id.toString())
    .update(task)
    .whenComplete(() => {
      print("successful update")
    });
}


Future<void> _deleteFirestoreData(String id) async {
    db
        .collection("tasks")
        .doc(id)
        .delete()
        .then(
          (doc) => print("Document deleted"),
          onError: (e) => print("Error updating document $e"),
        );
  }



import 'package:firebase_analytics/firebase_analytics.dart';

FirebaseAnalytics analytics = FirebaseAnalytics.instance;


import 'package:firebase_crashlytics/firebase_crashlytics.dart';
FirebaseCrashlytics.instance.crash();
