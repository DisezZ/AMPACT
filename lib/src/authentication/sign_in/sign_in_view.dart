import 'package:flutter/material.dart';

import 'sign_in_controller.dart';

class SignInView extends StatefulWidget {
  final Function() onRegisterClicked;

  const SignInView({
    Key? key,
    required this.onRegisterClicked,
  }) : super(key: key);

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final SignInController controller = SignInController();

  @override
  void dispose() {
    controller.email.dispose();
    controller.password.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
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
                  controller: controller.email,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Type your email',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: controller.validateEmail,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                TextFormField(
                  controller: controller.password,
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: controller.validatePassword,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () =>
                          controller.onForgotPasswordPressed(context),
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    TextButton(
                      onPressed: widget.onRegisterClicked,
                      child: const Text(
                        'Register Now',
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
                        onPressed: () {
                          controller.onSignInPressed(context);
                          print('hhh');
                        },
                        child: const Text(
                          'Sign In',
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
                SizedBox(
                  height: size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.height_rounded),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.expand_more_outlined),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*
Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'AMPACT',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              TextField(
                onChanged: controller.onIdentifierChanged,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  filled: true,
                  fillColor: Colors.blue[50],
                  labelText: 'ID',
                  labelStyle: const TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              TextField(
                onChanged: controller.onPasswordChanged,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  filled: true,
                  fillColor: Colors.blue[50],
                  labelText: 'Password',
                  labelStyle: const TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              SizedBox(
                width: size.width * 0.5,
                child: CheckboxListTile(
                  title: const Text(
                    'Always Login',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  checkColor: Colors.white,
                  value: controller.checked,
                  onChanged: (bool? value) {
                    setState(() {
                      controller.checked = value;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              SizedBox(
                width: size.width * 0.35,
                height: size.height * 0.06,
                child: ElevatedButton(
                  onPressed: controller.onSignInPressed,
                  child: const Text(
                    'Sign In',
                    style: TextStyle(fontSize: 22),
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    )),
                  ),
                ),
              ),
            ],
          ),
 */
