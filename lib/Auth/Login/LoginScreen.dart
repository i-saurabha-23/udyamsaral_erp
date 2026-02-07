import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:udyamsaral_erp/Auth/ForgotPassword/ForgotPasswordScreen.dart';
import 'package:udyamsaral_erp/Auth/Register/RegisterScreen.dart';
import 'package:udyamsaral_erp/Screens/DashboardScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  bool isEmailValid(String email) {
    if (!email.contains('@')) {
      debugPrint("Enter a valid email");
      return false;
    }

    int indexAt = email.indexOf('@');
    int indexDot = email.indexOf('.', indexAt);

    if (indexDot < indexAt) {
      debugPrint("Enter a valid email");
      return false;
    }

    debugPrint("Email validated");
    return true;
  }

  Future<void> handelSignIn({
    required String email,
    required String password,
  }) async {
    setState(() {
      isLoading = true;
    });

    if (!isEmailValid(email)) {
      debugPrint("Email validation failed");
      return;
    }

    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      User? user = credential.user;

      setState(() {
        isLoading = false;
      });

      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Login successful',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.blue,
          ),
        );

        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => DashboardScreen(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      debugPrint("$e");

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Row(
          children: [
            Flexible(
              flex: 3,
              child: SizedBox.expand(
                child: Image.asset(
                  'lib/assets/login_backdrop.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: SizedBox.expand(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 8),

                    Text('Sign in with you email and password'),

                    SizedBox(height: 24),

                    Container(
                      height: 100,
                      width: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(
                        Icons.security,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),

                    SizedBox(height: 24),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          TextField(
                            controller: emailController,

                            style: TextStyle(color: Colors.black),
                            cursorColor: Colors.blue,

                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.shade50,

                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.grey),
                              floatingLabelStyle: TextStyle(color: Colors.blue),

                              hintText: 'Enter your email here',
                              hintStyle: TextStyle(color: Colors.grey),

                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.blue),
                              ),

                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(8),
                              ),

                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                          ),

                          SizedBox(height: 24),

                          TextField(
                            controller: passwordController,

                            style: TextStyle(color: Colors.black),
                            cursorColor: Colors.blue,

                            obscureText: true,

                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.shade50,

                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.grey),
                              floatingLabelStyle: TextStyle(color: Colors.blue),

                              hintText: 'Enter your password here',
                              hintStyle: TextStyle(color: Colors.grey),

                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.blue),
                              ),

                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(8),
                              ),

                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                          ),

                          SizedBox(height: 24),

                          ElevatedButton(
                            onPressed: () async {
                              String email = emailController.text.trim();
                              String password = passwordController.text.trim();

                              await handelSignIn(
                                email: email,
                                password: password,
                              );
                            },

                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(500, 48),
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              elevation: 3,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),

                            child: isLoading
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text('Login', style: TextStyle(fontSize: 16)),
                          ),

                          SizedBox(height: 24),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (_, __, ___) =>
                                          ForgotPasswordScreen(),
                                      transitionDuration: Duration.zero,
                                      reverseTransitionDuration: Duration.zero,
                                    ),
                                  );
                                },
                                child: Text(
                                  'Forgot Password',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (_, __, ___) =>
                                          RegisterScreen(),
                                      transitionDuration: Duration.zero,
                                      reverseTransitionDuration: Duration.zero,
                                    ),
                                  );
                                },
                                child: Text(
                                  'Sign up',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
