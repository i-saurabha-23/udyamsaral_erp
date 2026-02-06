import 'package:flutter/material.dart';
import 'package:udyamsaral_erp/Auth/Login/LoginScreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                            onPressed: () {},

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

                            child: Text(
                              'Login',
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
