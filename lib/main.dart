import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_demo/Screens/navigator.dart';
import 'Screens/sign_in_screen.dart';
import 'Screens/sign_up_screen.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: NavigatorScreen(),
      home: const SignInScreen(),
      routes: {
        SignUpScreen.id : (context) => SignUpScreen(),
        SignInScreen.id : (context) => SignInScreen(),
        NavigatorScreen.id : (context) => NavigatorScreen()
      },
    );
  }
}
