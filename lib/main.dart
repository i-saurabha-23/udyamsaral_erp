import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:udyamsaral_erp/Auth/Login/LoginScreen.dart';
import 'package:udyamsaral_erp/constants/firebase.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    const firebaseOptions = FirebaseOptions(
      apiKey: API_KEY,
      authDomain: AUTH_DOMAIN,
      projectId: PROJECT_ID,
      storageBucket: STORAGE_BUCKET,
      messagingSenderId: MESSAGING_SENDER_ID,
      appId: APP_ID,
      measurementId: MEASUREMENT_ID,
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
