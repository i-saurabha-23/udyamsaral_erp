import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vyavastha_vistar/Auth/Login/LoginScreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  String? nameError;
  String? emailError;
  String? phoneError;
  String? passwordError;

  String? generalError;

  bool isEmailValid(String email) {
    if (email.isEmpty) return false;
    if (!email.contains('@')) return false;
    int atIndex = email.indexOf('@');
    int dotIndex = email.indexOf('.', atIndex);
    if (dotIndex < atIndex) return false;
    return true;
  }

  bool isPhoneValid(String phone) {
    String cleanPhone = phone.replaceAll(RegExp(r'[^0-9]'), '');
    return cleanPhone.length == 10;
  }

  bool isPasswordValid(String password) {
    return password.length >= 8;
  }

  bool validateFields() {
    setState(() {
      nameError = null;
      emailError = null;
      phoneError = null;
      passwordError = null;

      if (nameController.text.trim().isEmpty) {
        nameError = 'Name is required';
      }

      if (emailController.text.trim().isEmpty) {
        emailError = 'Email is required';
      } else if (!isEmailValid(emailController.text.trim())) {
        emailError = 'Please enter a valid email address';
      }

      if (phoneController.text.trim().isEmpty) {
        phoneError = 'Phone number is required';
      } else if (!isPhoneValid(phoneController.text.trim())) {
        phoneError = 'Phone number must be 10 digits';
      }

      if (passwordController.text.isEmpty) {
        passwordError = 'Password is required';
      } else if (!isPasswordValid(passwordController.text)) {
        passwordError = 'Password must be at least 8 characters';
      }
    });

    return nameError == null &&
        emailError == null &&
        phoneError == null &&
        passwordError == null;
  }

  Future<void> createUserWithEmailAndPassword() async {
    setState(() {
      generalError = null;
      isLoading = true;
    });

    if (!validateFields()) {
      setState(() => isLoading = false);
      return;
    }

    try {
      UserCredential credentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      User? user = credentials.user;

      if (user == null) {
        throw Exception('User creation failed');
      }

      await FirebaseFirestore.instance.collection('user').doc(user.uid).set({
        'email': emailController.text.trim(),
        'name': nameController.text.trim(),
        'phone': phoneController.text.trim(), // FIXED
        'createdAt': FieldValue.serverTimestamp(),
      });

      // ✅ SUCCESS → STOP LOADER
      setState(() {
        isLoading = false;
      });

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => LoginScreen(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        generalError = e.message;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        generalError = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Light background to make card stand out
      backgroundColor: const Color(0xFFF5F5F5),

      body: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(20),

          child: Card(
            color: Colors.white,

            // Softer shadow with more blur
            elevation: 8,
            shadowColor: Colors.black26,

            // Rounded corners for modern look
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),

            child: Padding(
              padding: const EdgeInsets.all(40),

              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title
                  const Text(
                    'Sign Up.',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Subtitle
                  Text(
                    'Create your account',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),

                  const SizedBox(height: 32),

                  // Name Field
                  TextField(
                    controller: nameController,

                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(color: Colors.black),
                      hintText: 'John Doe',

                      errorText: nameError,

                      // Icon on left side
                      prefixIcon: const Icon(Icons.person_outline),

                      // Light background
                      filled: true,
                      fillColor: Colors.grey[50],

                      // Border styling
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
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Email Field
                  TextField(
                    controller: emailController,

                    keyboardType: TextInputType.emailAddress,

                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.black),
                      hintText: 'abc@example.com',

                      errorText: emailError,

                      prefixIcon: const Icon(Icons.email_outlined),

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
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Phone Field
                  TextField(
                    controller: phoneController,

                    keyboardType: TextInputType.phone,

                    decoration: InputDecoration(
                      labelText: 'Phone',
                      labelStyle: TextStyle(color: Colors.black),
                      hintText: '+91 90xxxxxx02',

                      errorText: phoneError,

                      prefixIcon: const Icon(Icons.phone_outlined),

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
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
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

                      errorText: passwordError,

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

                  const SizedBox(height: 28),

                  // Sign Up Button
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () {
                        isLoading ? null : createUserWithEmailAndPassword();
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
                              'Sign Up',
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

                  // Login Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already Have An Account? ',
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),

                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            // Navigate to login
                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => LoginScreen(),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            );
                          },
                          child: const Text(
                            'Login',
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
