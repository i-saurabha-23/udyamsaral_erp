import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:udyamsaral_erp/Auth/Login/LoginScreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cnfPassController = TextEditingController();

  bool isLoading = false;

  bool isEmailValid(String email) {
    debugPrint("Email received: $email");

    if (!email.contains('@')) {
      debugPrint("Enter corect email");
      return false;
    }

    int indexAt = email.indexOf('@');
    int indexDot = email.indexOf('.', indexAt);

    if (indexDot < indexAt) {
      debugPrint("Dot not after @");
      return false;
    }

    debugPrint("Email validated");
    return true;
  }

  bool isCodeValid(String code) {
    if (code == 0) {
      debugPrint("Counter code can not be 0");
      return false;
    }

    if (code.length > 3) {
      debugPrint("Country code can not be greater than 3 digits");
      return false;
    }

    debugPrint("Code validated");
    return true;
  }

  bool isPhoneValid(String phone) {
    if (phone.length != 10) {
      debugPrint("Phone number should be off 10 digits");
      return false;
    }

    debugPrint("Phone validated");
    return true;
  }

  bool isPassValid(String password, String cnfPassword) {
    if (password.length < 8) {
      debugPrint("Password should be 8 characters long");
      return false;
    }

    if (password != cnfPassword) {
      debugPrint("Passwords are not matching");
      return false;
    }

    debugPrint("Password validated");
    return true;
  }

  Future<void> handleSignup({
    required String name,
    required String code,
    required String phone,
    required String email,
    required String password,
    required String cnfPassword,
  }) async {
    setState(() {
      isLoading = true;
    });

    if (!isEmailValid(email)) {
      debugPrint("Email validation failed");
      return;
    }

    if (!isCodeValid(code)) {
      debugPrint("Code validation failed");
      return;
    }

    if (!isPhoneValid(phone)) {
      debugPrint("Phone validation failed");
      return;
    }

    if (!isPassValid(password, cnfPassword)) {
      debugPrint("Password validation failed");
      return;
    }

    String? uid = await signUpWithFirebase(email: email, password: password);

    if (uid != null) {
      try {
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'name': name,
          'email': email,
          'code': code,
          'phone': phone,
          'createdAt': DateTime.now(),
        });

        debugPrint("Uses stored in Firestore");

        setState(() {
          isLoading = false;
        });

        // Clear all the form fields
        nameController.clear();
        emailController.clear();
        codeController.clear();
        phoneController.clear();
        passwordController.clear();
        cnfPassController.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Registration successful. Redirecting to login page....',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.blue,
          ),
        );

        await Future.delayed(Duration(seconds: 2));

        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => LoginScreen(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      } catch (e) {
        debugPrint("$e");

        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<String?> signUpWithFirebase({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = credential.user;

      if (user != null) {
        debugPrint("User created with the uid: ${user.uid}");

        return user.uid;
      } else {
        debugPrint("UID is null");

        return null;
      }
    } on FirebaseAuthException catch (e) {
      debugPrint("Error: $e");

      return null;
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
                      'Register',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 8),

                    Text('We are waiting to take you in.'),

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
                            controller: nameController,

                            style: TextStyle(color: Colors.black),
                            cursorColor: Colors.blue,

                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.shade50,

                              labelText: 'Name',
                              labelStyle: TextStyle(color: Colors.grey),
                              floatingLabelStyle: TextStyle(color: Colors.blue),

                              hintText: 'Enter your name here',
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

                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: TextField(
                                  controller: codeController,

                                  style: TextStyle(color: Colors.black),
                                  cursorColor: Colors.blue,

                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey.shade50,

                                    labelText: 'Code',
                                    labelStyle: TextStyle(color: Colors.grey),
                                    floatingLabelStyle: TextStyle(
                                      color: Colors.blue,
                                    ),

                                    hintText: '+91',
                                    hintStyle: TextStyle(color: Colors.grey),

                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),

                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),

                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(width: 10),

                              Flexible(
                                flex: 4,
                                child: TextField(
                                  controller: phoneController,

                                  style: TextStyle(color: Colors.black),
                                  cursorColor: Colors.blue,

                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey.shade50,

                                    labelText: 'Phone',
                                    labelStyle: TextStyle(color: Colors.grey),
                                    floatingLabelStyle: TextStyle(
                                      color: Colors.blue,
                                    ),

                                    hintText: 'Enter your phone here',
                                    hintStyle: TextStyle(color: Colors.grey),

                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),

                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),

                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 24),

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

                          TextField(
                            controller: cnfPassController,

                            style: TextStyle(color: Colors.black),
                            cursorColor: Colors.blue,

                            obscureText: true,

                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.shade50,

                              labelText: 'Confirm Password',
                              labelStyle: TextStyle(color: Colors.grey),
                              floatingLabelStyle: TextStyle(color: Colors.blue),

                              hintText: 'Enter your confirm password here',
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
                              String name = nameController.text.trim();
                              String code = codeController.text.trim();
                              String phone = phoneController.text.trim();
                              String email = emailController.text.trim();
                              String password = passwordController.text.trim();
                              String cnfPassword = cnfPassController.text
                                  .trim();

                              await handleSignup(
                                name: name,
                                code: code,
                                phone: phone,
                                email: email,
                                password: password,
                                cnfPassword: cnfPassword,
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
                                : Text(
                                    'Sign Up',
                                    style: TextStyle(fontSize: 16),
                                  ),
                          ),

                          SizedBox(height: 24),

                          Container(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (_, __, ___) => LoginScreen(),
                                    transitionDuration: Duration.zero,
                                    reverseTransitionDuration: Duration.zero,
                                  ),
                                );
                              },
                              child: Text(
                                'Sign in',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
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
