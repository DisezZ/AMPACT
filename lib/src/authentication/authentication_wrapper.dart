import 'package:ampact/src/authentication/authentication_provider.dart';
import 'package:ampact/src/authentication/register/register_view.dart';
import 'package:ampact/src/authentication/sign_in/sign_in_view.dart';
import 'package:ampact/src/navigation/home/home_view.dart';
import 'package:ampact/src/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/user_info.dart';

class AuthenticationWrapper extends StatefulWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);
  static const routeName = "/signin";

  @override
  _AuthenticationWrapperState createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    final currentPage = context.watch<AuthenticationProvider>().currentPage;
    final signInPage = context.watch<AuthenticationProvider>().signInPage;
    //final registerPage = context.watch<AuthenticationProvider>().registerPage;

    if (user == null) {
      if (currentPage == signInPage) {
        return const SignInView();
      } else {
        return const RegisterView();
      }
    } else {
      return StreamProvider.value(
        initialData: null,
        value: DatabaseService().userStream,
        child: const HomeView(),
      );
    }
  }
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

