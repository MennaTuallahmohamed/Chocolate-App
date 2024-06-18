import 'package:chocklateapp/view/auth/register_view.dart';
import 'package:chocklateapp/view/widgets/custom_buttom.dart';
import 'package:chocklateapp/view/widgets/custom_buttom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chocklateapp/view/widgets/custom_text_form_field.dart';
import 'package:chocklateapp/view/widgets/custom_text.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../constance.dart';
import '../../core/view_model/auth_view_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? email, password;
  final AuthViewModel controller = AuthViewModel();

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(
                      text: "Welcome,",
                      fontSize: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterView()),
                        );
                      },
                      child: const CustomText(
                        text: "Sign Up",
                        color: primaryColor,
                        fontSize: 18,
                      ),
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
                CustomTextFormField(
                  text: 'Email',
                  hint: 'Enter your Email',
                  onChanged: (value) {
                    email = value;
                    controller.email = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your email";
                    }
                    return null;
                  },
                  controller: emailController,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  text: 'Password',
                  hint: 'Enter your Password',
                  onChanged: (value) {
                    password = value;
                    controller.password = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your password";
                    }
                    return null;
                  },
                  controller: passwordController,
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
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      controller.signInWithEmailAndPassword();
                    }
                  },
                  child: CustomButton(
                    text: 'SIGN IN',
                    onPress: () {
                      _formKey.currentState!.save();
                    },
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                const CustomText(
                  text: '-OR-',
                  alignment: Alignment.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    controller.googleSignInMethod();
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
                    controller.facebookSignInMethod();
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
}
