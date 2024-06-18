import 'package:chocklateapp/view/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:chocklateapp/core/service/firestore_user.dart';
import 'package:chocklateapp/model/user_model.dart';

class AuthViewModel extends GetxController {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late String email, password, name;

  final Rx<User?> _user = Rx<User?>(null);

  String? get user => _user.value?.email;

  @override
  void onInit() {
    super.onInit();
    _user.bindStream(_auth.authStateChanges());
  }

  Future<void> googleSignInMethod() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        await _auth.signInWithCredential(credential).then((userCredential) {
          saveUser(userCredential.user!);
          Get.offAll(() => HomeView());
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> facebookSignInMethod() async {
    try {
      final FacebookLogin _facebookLogin = FacebookLogin();

      final FacebookLoginResult result = await _facebookLogin.logIn(
        permissions: [
          FacebookPermission.publicProfile,
          FacebookPermission.email,
        ],
      );

      if (result.status == FacebookLoginStatus.success) {
        final accessToken = result.accessToken;
        final faceCredential =
            FacebookAuthProvider.credential(accessToken!.token);
        await _auth.signInWithCredential(faceCredential).then((userCredential) {
          saveUser(userCredential.user!);
          Get.offAll(() => HomeView());
        });
      }
    } catch (error) {
      print("Error during Facebook sign-in: $error");
    }
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAll(() => HomeView());
    } catch (e) {
      print(e.toString());
      Get.snackbar(
        'Error login account',
        e.toString(),
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> createAccountWithEmailAndPassword() async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((userCredential) async {
        await saveUser(userCredential.user!);
      });

      Get.offAll(() => HomeView());
    } catch (e) {
      print(e.toString());
      Get.snackbar(
        'Error creating account',
        e.toString(),
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> saveUser(User user) async {
    try {
      await FireStoreUser().addUserToFireStore(UserModel(
        userId: user.uid,
        email: user.email ?? "",
        name: name.isNotEmpty ? name : user.displayName ?? '',
        pic: '',
      ));
    } catch (e) {
      print("Error saving user: $e");
    }
  }
}
