import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:udyamsaral_erp/Auth/Login/LoginScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    const firebaseOptions = FirebaseOptions(
      apiKey: "AIzaSyAXx5YTupgJ6fCl6OhOX6fINGDt1Wi0UTg",
      authDomain: "udyamsaral-erp.firebaseapp.com",
      projectId: "udyamsaral-erp",
      storageBucket: "udyamsaral-erp.firebasestorage.app",
      messagingSenderId: "409096617835",
      appId: "1:409096617835:web:101d07be90d0a5b34b162e",
      measurementId: "G-339ECXCJC0",
    );

    await Firebase.initializeApp(options: firebaseOptions);

    debugPrint("Firebase initialised successfully");
  } catch (e) {
    debugPrint("$e");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', home: LoginScreen());
  }
}
