import 'package:chocklateapp/view/widgets/custom_buttom.dart';
import 'package:flutter/material.dart';
import 'package:chocklateapp/view/widgets/custom_buttom.dart';
import 'package:chocklateapp/view/widgets/custom_text_form_field.dart';
import 'package:chocklateapp/view/widgets/custom_text.dart';
import 'package:chocklateapp/core/view_model/auth_view_model.dart';
import 'package:chocklateapp/view/auth/login_screen.dart';
import 'package:chocklateapp/view/home_view.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthViewModel controller = AuthViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
                (Route<dynamic> route) => false,
          ),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 50,
          right: 20,
          left: 20,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const CustomText(
                text: "Sign Up",
                fontSize: 30,
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextFormField(
                controller: TextEditingController(),
                text: 'Name',
                hint: 'Enter your name',
                onChanged: (value) => controller.name = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your name";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextFormField(
                controller: TextEditingController(),
                text: 'Email',
                hint: 'Enter your email',
                onChanged: (value) => controller.email = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your email";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextFormField(
                controller: TextEditingController(),
                text: 'Password',
                hint: 'Enter your password',
                onChanged: (value) => controller.password = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your password";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              CustomButton(
                onPress: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    controller.createAccountWithEmailAndPassword().then((_) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomeView()),
                            (Route<dynamic> route) => false,
                      );
                    });
                  }
                },
                text: 'SIGN UP',
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

