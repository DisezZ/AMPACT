import 'package:ampact/src/authentication/sign_in/sign_in_view.dart';
import 'package:flutter/material.dart';

import 'register_controller.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);
  static const routeName = '/register';

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  RegisterController controller = RegisterController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
        child: Center(
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo_ampact.png'),
                TextFormField(
                  onSaved: controller.onEmailSaved,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Type your email',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  validator: controller.validateEmail,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                TextFormField(
                  onChanged: controller.onPasswordChanged,
                  obscureText: !controller.passwordVisibility,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Type your password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          controller.passwordVisibility =
                          !controller.passwordVisibility;
                        });
                      },
                      icon: controller.passwordVisibility
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  validator: controller.validatePassword,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                TextFormField(
                  onSaved: controller.onConfirmPasswordSaved,
                  obscureText: !controller.confirmPasswordVisibility,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    hintText: 'Type your confirm password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          controller.confirmPasswordVisibility =
                          !controller.confirmPasswordVisibility;
                        });
                      },
                      icon: controller.confirmPasswordVisibility
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  validator: controller.validateConfirmPassword,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => controller.onBackToSignInPressed(context),
                      child: const Text(
                        'Back to Sign In',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: size.height * 0.06,
                      child: ElevatedButton(
                        onPressed: () => controller.onRegisterPressed(context),
                        child: const Text(
                          'Register',
                          style: TextStyle(fontSize: 20),
                        ),
                        style: ButtonStyle(
                          shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

