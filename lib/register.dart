import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home/dbClasses.dart';
import 'package:home/loginSc.dart';
import 'package:home/sub.dart';
import 'package:home/utils/utilities.dart';

class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  void dispose() {
    super.dispose();
    name.dispose();
    phone.dispose();
    email.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return true;
        },
        child: Scaffold(
          // resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                          height: 70,
                          width: 70,
                          image: AssetImage('assets/logo.jpeg')),
                      Column(
                        children: [
                          Text(
                            'Semester',
                            style: TextStyle(
                              fontFamily: 'Pacifico',
                              fontSize: 25,
                              color: Colors.lightGreen.shade400,
                            ),
                          ),
                          Text(
                            'Planner',
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.indigo.shade900,
                                fontFamily: 'Pacifico'),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontFamily: 'Pacifico'),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 8),
                        child: TextFormField(
                          controller: name,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter name';
                            } else
                              return null;
                          },
                          decoration: InputDecoration(
                              hintText: 'Name',
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.grey.shade400,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(20),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 8),
                        child: TextFormField(
                          controller: phone,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter phone no';
                            } else
                              return null;
                          },
                          decoration: InputDecoration(
                              hintText: 'Contact',
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Icon(
                                Icons.phone_android,
                                color: Colors.grey.shade400,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(20),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 8),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: email,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter email';
                            } else
                              return null;
                          },
                          decoration: InputDecoration(
                              hintText: 'Email',
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.grey.shade400,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(20),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 8),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: password,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter password';
                            } else
                              return null;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: 'Password',
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.grey.shade400,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(20),
                              )),
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        // _auth.currentUser()

                        setState(() {
                          loading = true;
                        });
                        _auth
                            .createUserWithEmailAndPassword(
                                email: email.text.toString(),
                                password: password.text.toString())
                            .then((value) {
                          setState(() {
                            loading = false;
                          });
                          utilities().toastMessages('Registered Successfully');
                        }).onError((error, stackTrace) {
                          utilities().toastMessages(error.toString());
                          setState(() {
                            loading = false;
                          });
                        });
                      }
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => login()));
                    },
                    child: Container(
                      height: 45,
                      width: 300,
                      decoration: BoxDecoration(
                          color: Colors.indigo.shade900,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: loading
                              ? CircularProgressIndicator(
                                  strokeWidth: 3,
                                  color: Colors.white,
                                )
                              : Text(
                                  'SignUp',
                                  style: TextStyle(
                                    fontFamily: 'Pacifico',
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                )),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Registered already?',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Pacifico',
                          color: Colors.black,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => login()));
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Pacifico',
                            color: Colors.lightGreen.shade400,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
    ;
  }
}
