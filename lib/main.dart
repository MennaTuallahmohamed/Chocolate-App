import 'package:chocklateapp/view/widgets/custom_buttom.dart';
import 'package:chocklateapp/view/widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chocklateapp/view/auth/register_view.dart';

import 'constance.dart';
import 'helper/binding.dart';
import 'view/auth/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp(key: Key('myApp')));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: Login(),
    );
  }
}

class Login extends StatelessWidget {
  Login({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.brown[500],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 50,
            right: 20,
            left: 20,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "Welcome,",
                      fontSize: 30,
                    ),
                    CustomText(
                      text: "Sign Up",
                      color: primaryColor,
                      fontSize: 18,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const CustomText(
                  text: "Sign in to continue",
                  color: Colors.grey,
                  fontSize: 14,
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: emailController,
                  validator: (value){
                    if (value!.isEmpty) {
                      return 'Please Enter Email Address!';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    label: Text('email'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  validator: (value){
                    if (value!.isEmpty) {
                      return 'Please Enter Email Address!';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.password),
                    label: Text('password'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText(
                      text: 'Forgot password?',
                      fontSize: 14,
                      alignment: Alignment.topRight,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: 'SIGN IN',
                  onPress: () {
                    if (_formKey.currentState!.validate()) {
                      userLogin(email: emailController.text, password: passwordController.text);
                    }
                  },
                  color: Colors.white,
                ),
                const SizedBox(height: 20),
                const CustomText(
                  text: '-OR-',
                  alignment: Alignment.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    //controller.googleSignInMethod();
                    // signInWithGoogle();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.asset('assets/images/google.png'),
                      const SizedBox(width: 10),
                      const CustomText(
                        text: 'Sign in with Google',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    //controller.facebookSignInMethod();
                    // signInWithFacebook();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.asset('assets/images/facebook.png'),
                      const SizedBox(width: 10),
                      const CustomText(
                        text: 'Sign in with Facebook',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void userLogin({
    required String email,
    required String password,
  }){
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      print(value.user?.email);
      print(value.user?.uid);
    }).catchError((error)
    {

    });

  }
}


