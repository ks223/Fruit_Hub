import 'package:flutter/material.dart';
import 'package:fruit_hub/view/loginscreen.dart';
import 'package:fruit_hub/view/registrationscreen.dart';

import 'model/themes.dart';
import 'view/splashscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: CustomTheme.lighttheme,
        routes: <String, WidgetBuilder>{
          '/loginscreen': (BuildContext context) => new LoginScreen(),
          '/registerscreen': (BuildContext context) => new RegistrationScreen(),
        },
        title: 'Fruit Hub',
        home: SplashScreen());
  }
}
