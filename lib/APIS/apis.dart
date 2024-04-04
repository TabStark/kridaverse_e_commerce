import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kridaverse_e_commerce/Custom%20Widgets/custom_bottom_navbar.dart';
import 'package:kridaverse_e_commerce/Custom%20Widgets/popup_and_loader.dart';
import 'package:kridaverse_e_commerce/Custom%20Widgets/reusable_bottom_navbar.dart';
import 'package:kridaverse_e_commerce/Model/addtocart_model.dart';
import 'package:kridaverse_e_commerce/Model/logged_user.dart';
import 'package:kridaverse_e_commerce/screens/home_screen.dart';
import 'package:kridaverse_e_commerce/screens/login_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class Apis {
  // Firease Auth
  static FirebaseAuth auth = FirebaseAuth.instance;

  // Firebase Cloud
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Current user auth
  static User get user => auth.currentUser!;

  // Check the user is exist or not
  static Future<bool> userExists() async {
    return (await firestore.collection('users').doc(user.uid).get()).exists;
  }

  // Create new user in cloud firestore
  static Future<void> createUser() async {
    final loggedUser = LoggedUser(
        img: user.photoURL?.toString() ??
            'https://png.pngitem.com/pimgs/s/274-2748514_profile-icon-material-design-hd-png-download.png',
        address: "",
        phone: user.phoneNumber.toString(),
        name: user.displayName.toString(),
        email: user.email.toString(),
        id: user.uid);

    return await firestore
        .collection('users')
        .doc(user.uid)
        .set(loggedUser.toJson());
  }

  // Storing user data
  static LoggedUser me = LoggedUser(
    img: user.photoURL?.toString() ??
        'https://png.pngitem.com/pimgs/s/274-2748514_profile-icon-material-design-hd-png-download.png',
    address: '',
    phone: user.phoneNumber.toString(),
    name: user.displayName.toString(),
    id: user.uid.toString(),
    email: user.email.toString(),
  );

  // Getting user data
  static Future getUserData() async {
    await firestore.collection('users').doc(user.uid).get().then((user) async {
      if (user.exists) {
        me = LoggedUser.fromJson(user.data()!);
      } else {
        await createUser().then((value) => getUserData);
      }
    });
  }

  // Default stream Builder
  static CollectionReference<Object?> fetchstream(String Collction) {
    final CollectionReference collections = firestore.collection(Collction);

    return collections;
  }

  // Fetch Add to cart
  static CollectionReference<Object?> fetchAddtoCartstream(
      String Collction, String docs, String subCollection) {
    final CollectionReference collections =
        firestore.collection(Collction).doc(docs).collection(subCollection);

    return collections;
  }

  // AddtoCart
  static Future<void> addtocart(
      String brandId, DocumentSnapshot documentSnapshot) async {
    await firestore
        .collection('users')
        .doc(user.uid)
        .collection('myaddtocart')
        .doc(brandId)
        .get()
        .then((value) async {
      if (value.exists) {
        await firestore
            .collection('users')
            .doc(user.uid)
            .collection('myaddtocart')
            .doc(brandId)
            .update({"qty": value['qty'] + 1});
      } else {
        final Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        final AddtoCartJson dids = AddtoCartJson(
          img: documentSnapshot['img'],
          price: documentSnapshot['price'],
          name: documentSnapshot['name'],
          discription: documentSnapshot['discription'],
          qty: 1,
        );

        firestore
            .collection('users')
            .doc(user.uid)
            .collection('myaddtocart')
            .doc(brandId)
            .set(dids.toJson());
      }
    });
  }

  // remove from cart
  static Future<void> removetocart(String brandId) async {
    await firestore
        .collection('users')
        .doc(user.uid)
        .collection('myaddtocart')
        .doc(brandId)
        .get()
        .then((value) async {
      if (value.exists) {
        print(value['qty']);
        await firestore
            .collection('users')
            .doc(user.uid)
            .collection('myaddtocart')
            .doc(brandId)
            .update({"qty": value['qty'] - 1});
      }
    });
  }

  // Delete from Cart
  static Future<void> deletefromcart(String brandId) async {
    await firestore
        .collection('users')
        .doc(user.uid)
        .collection('myaddtocart')
        .doc(brandId)
        .get()
        .then((value) async {
      if (value.exists) {
        print(value['qty']);
        await firestore
            .collection('users')
            .doc(user.uid)
            .collection('myaddtocart')
            .doc(brandId)
            .delete();
      }
    });
  }

  // Sign In With Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print("signInWithGoogle: ${e} ");

      return null;
    }
  }

  // Sign Up with Email
  Future<UserCredential?> signUpWithEmail(
      BuildContext context, Useremail, Userpassword) async {
    try {
      final Credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: Useremail, password: Userpassword)
          .then((user) async {
        // From here itself moving to home screen
        if (user != null) {
          print("User Detail : ${user.user}");
          Navigator.pop(context);
          if (await userExists()) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const ReusableBottomNavbar()));
          } else {
            await createUser().then((value) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ReusableBottomNavbar()));
            });
          }
        }
      });
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'weak-password') {
        print('The Password provided is too weak');
        DialogsWidget.showFlushBar(
            context, "The Password provided is too weak");
      } else if (e.code == 'email-already-in-use') {
        print('The account already exist for that email.');
        DialogsWidget.showFlushBar(context, "The Email Id is already in use");
      }
    } catch (e) {
      print("signUpWithEmail: ${e} ");
      DialogsWidget.showFlushBar(
          context, "Something went wrong try again later");
      return null;
    }
  }

  // Signin with Email
  Future<UserCredential?> signInWithEmail(
      BuildContext context, String Useremail, String UserPassword) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: Useremail, password: UserPassword)
          .then((user) async {
        if (user != null) {
          Navigator.pop(context);
          print("User Detail : ${user.user}");
          if (await userExists()) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const ReusableBottomNavbar()));
          } else {
            await createUser().then((value) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ReusableBottomNavbar()));
            });
          }
        }
      });
    } on FirebaseAuthException catch (e) {
      // print('Error gone ${e.code}');
      Navigator.pop(context);
      if (e.code == 'invalid-credential') {
        print('Invalid user name or password.');
        DialogsWidget.showFlushBar(context, "Invalid user name or password.");
      }
    } catch (e) {
      print("signInWithEmail: ${e} ");
      DialogsWidget.showFlushBar(
          context, "Something went wrong try again later");
      return null;
    }
  }

  // Logout
  Future<void> logoutFromDevice(BuildContext context) async {
    // DialogsWidget.showProgressBar(context, animationcontroller);
    await Apis.auth.signOut().then((value) async {
      await GoogleSignIn().signOut().then((value) {
        Apis.auth = FirebaseAuth.instance;
        pushWithoutNavBar(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      });
    });
  }
}
