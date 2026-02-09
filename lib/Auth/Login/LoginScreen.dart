import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vyavastha_vistar/Auth/Register/RegisterScreen.dart';
import 'package:vyavastha_vistar/Screens/DashboardScreen.dart';
import 'package:vyavastha_vistar/Screens/DashboardScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? emailError;
  String? passwordError;

  String? generalError;

  bool isLoading = false;

  bool isEmailValid(String email) {
    if (email.isEmpty) return false;
    if (!email.contains('@')) return false;
    int atIndex = email.indexOf('@');
    int dotIndex = email.indexOf('.', atIndex);
    if (dotIndex < atIndex) return false;
    return true;
  }

  bool validateFields() {
    setState(() {
      emailError = null;
      passwordError = null;

      if (emailController.text.trim().isEmpty) {
        emailError = 'Email can not be empty';
      } else if (!isEmailValid(emailController.text.trim())) {
        emailError = 'Enter a valid email';
      }
    });

    return emailError == null;
  }

  Future<void> signInUserWithEmailAndPassword() async {
    setState(() {
      generalError = null;
      isLoading = true;
    });

    if (!validateFields()) {
      setState(() => isLoading = false);
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      setState(() {
        isLoading = false;
      });

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => DashboardScreen(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } on FirebaseAuthException catch (e) {
      generalError = e.message;
    }

    setState(() {
      generalError = null;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Light background to make card stand out
      backgroundColor: const Color(0xFFF5F5F5),

      body: Center(
        child: Container(
          width: 400,
          padding: EdgeInsets.all(20),

          child: Card(
            color: Colors.white,

            elevation: 8,
            shadowColor: Colors.black26,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),

            child: Padding(
              padding: EdgeInsets.all(40),

              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  Text(
                    'Sign In.',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    'Access your account',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),

                  SizedBox(height: 32),

                  TextField(
                    controller: emailController,

                    keyboardType: TextInputType.emailAddress,

                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.black),

                      errorText: emailError,

                      hint: Text('abc@example.com'),

                      prefixIcon: const Icon(Icons.mail_outline),

                      filled: true,
                      fillColor: Colors.grey[50],

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),

                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.red),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),

                  SizedBox(height: 16),

                  TextField(
                    controller: passwordController,

                    keyboardType: TextInputType.visiblePassword,

                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.black),

                      hint: Text('********'),

                      prefixIcon: const Icon(Icons.password_outlined),

                      filled: true,
                      fillColor: Colors.grey[50],

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () {
                        isLoading ? null : signInUserWithEmailAndPassword();
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,

                        // Rounded button
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),

                        // Remove shadow
                        elevation: 0,
                      ),

                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  if (generalError != null)
                    Text(
                      generalError!,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),

                  if (generalError != null) const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't Have An Account? ",
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),

                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => RegisterScreen(),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            );
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
