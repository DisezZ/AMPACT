import 'package:ampact/constants.dart';
import 'package:ampact/src/authentication/authentication_provider.dart';
import 'package:ampact/src/authentication/register/register_view.dart';
import 'package:ampact/src/navigation/home/home_view.dart';
import 'package:ampact/src/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';
import 'authentication/sign_in/sign_in_view.dart';
import 'authentication/authentication_wrapper.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MultiProvider(
          providers: [
            StreamProvider(create: (_) => AuthService().userStream, initialData: null),
            ChangeNotifierProvider<AuthenticationProvider>(create: (_) => AuthenticationProvider())
          ],
          //initialData: null,
          //value: AuthService().userStream,
          child: MaterialApp(
            // Providing a restorationScopeId allows the Navigator built by the
            // MaterialApp to restore the navigation stack when a user leaves and
            // returns to the app after it has been killed while running in the
            // background.
            restorationScopeId: 'app',

            // Provide the generated AppLocalizations to the MaterialApp. This
            // allows descendant Widgets to display the correct translations
            // depending on the user's locale.
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''), // English, no country code
            ],

            // Use AppLocalizations to configure the correct application title
            // depending on the user's locale.
            //
            // The appTitle is defined in .arb files found in the localization
            // directory.
            onGenerateTitle: (BuildContext context) =>
                AppLocalizations.of(context)!.appTitle,

            // Define a light and dark color theme. Then, read the user's
            // preferred ThemeMode (light, dark, or system default) from the
            // SettingsController to display the correct theme.
            theme: ThemeData(
              primaryColor: kPrimaryColor,
              scaffoldBackgroundColor: kBackgroundColor,
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFF387be7),
              ),
              textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            darkTheme: ThemeData.dark(),
            themeMode: settingsController.themeMode,

            // home
            home: const AuthenticationWrapper(),

            // Define a function to handle named routes in order to support
            // Flutter web url navigation and deep linking.
            onGenerateRoute: (RouteSettings routeSettings) {
              return MaterialPageRoute<void>(
                settings: routeSettings,
                builder: (BuildContext context) {
                  switch (routeSettings.name) {
                    case SettingsView.routeName:
                      return SettingsView(controller: settingsController);
                    case AuthenticationWrapper.routeName:
                      return const AuthenticationWrapper();
                    case SignInView.routeName:
                      return const SignInView();
                    case RegisterView.routeName:
                      return const RegisterView();
                    case HomeView.routeName:
                      return const HomeView();
                    default:
                      return const AuthenticationWrapper();
                  }
                },
              );
            },
          ),
        );
      },
    );
  }
}



/*
return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return StreamProvider.value(
          initialData: null,
          value: AuthService().userStream,
          child: MaterialApp(
            // Providing a restorationScopeId allows the Navigator built by the
            // MaterialApp to restore the navigation stack when a user leaves and
            // returns to the app after it has been killed while running in the
            // background.
            restorationScopeId: 'app',

            // Provide the generated AppLocalizations to the MaterialApp. This
            // allows descendant Widgets to display the correct translations
            // depending on the user's locale.
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''), // English, no country code
            ],

            // Use AppLocalizations to configure the correct application title
            // depending on the user's locale.
            //
            // The appTitle is defined in .arb files found in the localization
            // directory.
            onGenerateTitle: (BuildContext context) =>
                AppLocalizations.of(context)!.appTitle,

            // Define a light and dark color theme. Then, read the user's
            // preferred ThemeMode (light, dark, or system default) from the
            // SettingsController to display the correct theme.
            theme: ThemeData(),
            darkTheme: ThemeData.dark(),
            themeMode: settingsController.themeMode,

            // Define a function to handle named routes in order to support
            // Flutter web url navigation and deep linking.
            onGenerateRoute: (RouteSettings routeSettings) {
              return MaterialPageRoute<void>(
                settings: routeSettings,
                builder: (BuildContext context) {
                  switch (routeSettings.name) {
                    case SettingsView.routeName:
                      return SettingsView(controller: settingsController);
                    case AuthenticationWrapper.routeName:
                      return const AuthenticationWrapper();
                    case SignInView.routeName:
                      return const SignInView();
                    case RegisterView.routeName:
                      return const RegisterView();
                    case HomeView.routeName:
                      return const HomeView();
                    default:
                      return const AuthenticationWrapper();
                  }
                },
              );
            },
          ),
        );
      },
    );
 */