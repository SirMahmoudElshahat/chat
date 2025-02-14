import 'package:chat/screens/auth.dart';
import 'screens/chat.dart';
import 'package:chat/screens/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SplashScreen();
            }
            if (snapshot.hasData) {
              return const ChatScreen();
            } else {
              return AuthScreen();
            }
          })),
      routes: {
        'login': (context) => const AuthScreen(),
        'login/chat': (context) => const ChatScreen(),
      },
    );
  }
}
