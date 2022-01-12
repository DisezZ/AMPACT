import 'package:ampact/src/authentication/register/register_view.dart';
import 'package:ampact/src/authentication/sign_in/sign_in_view.dart';
import 'package:flutter/material.dart';

class AuthenticationWrapper extends StatefulWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  _AuthenticationWrapperState createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
      ? SignInView(onRegisterClicked: toggle)
      : RegisterView(onSignInClicked: toggle);

  void toggle() => setState(() => isLogin = !isLogin);
}

























/*class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);
  static const routeName = '/signin';

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<CustomUser?>(context);
    if (user == null) {
      return const SignInView();
    } else {
      return StreamProvider.value(
        initialData: null,
        value: DatabaseService().userStream,
        child: const HomeView(),
      );
    }
  }

  void changAuthPage(String pageName) {
    routeName = pageName;
  }
}*/

