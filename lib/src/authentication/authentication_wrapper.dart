import 'package:ampact/src/authentication/sign_in/sign_in_view.dart';
import 'package:ampact/src/navigation/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/user_info.dart';

/*Widget? authenticationWrapper(Key? key) {

}*/


class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    if (user == null) {
      return const SignInView();
    } else {
      return const HomeView();
    }
  }
}

