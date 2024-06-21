import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home/helpers/loader.dart';
import 'package:home/model/user_model.dart';
import 'package:home/screens/register.dart';
import 'package:home/screens/sub.dart';
import 'package:home/utils/utilities.dart';

String userId = '';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool loading = false;

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  final databaseRef = FirebaseDatabase.instance.ref("users");

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login(BuildContext context) {
    showLoader(context);
  setState(() {
    loading = true;
  });
  _auth
      .signInWithEmailAndPassword(
          email: emailController.text.toString(),
          password: passwordController.text.toString())
      .then((value) {
    userId = value.user!.uid;  // Get the user ID

    // Retrieve user data from the database
    databaseRef.child(userId).once().then((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        final userData = Map<String, dynamic>.from(event.snapshot.value as Map);
         final UserModel user = UserModel(map: userData);
        hideLoader(context);
        utilities().toastMessages('Welcome ${user.name}');

        // Navigate to the next screen with user data
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => sub(userData: user)));
      } else {
        hideLoader(context);

        utilities().toastMessages('User data not found.');
      }
      setState(() {
        loading = false;
      });
    }).catchError((error) {
        hideLoader(context);

      utilities().toastMessages(error.toString());
      setState(() {
        loading = false;
      });
    });
  }).onError((error, stackTrace) {
        hideLoader(context);

    utilities().toastMessages(error.toString());
    setState(() {
      loading = false;
    });
  });
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
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: SafeArea(
                  child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Image(
                            height: 70,
                            width: 70,
                            image: AssetImage('assets/logo.jpeg')),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Text(
                              'Semester',
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.lightGreen.shade400,
                                  fontFamily: 'Pacifico'),
                            ),
                            Text(
                              'Planner',
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.indigo.shade900,
                                  fontFamily: 'Pacifico'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Center(
                        child: Text(
                      'Log in',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontFamily: 'Pacifico'),
                    )),
                    SizedBox(
                      height: 20,
                    ),
                    const Center(
                        child: Text(
                      'For the students,\n By the students',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.black,
                          fontFamily: 'Rubik Italic VariableFont_wght'),
                    )),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                            controller: emailController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter email';
                              } else
                                return null;
                            },
                            decoration: InputDecoration(
                                hintText: 'Email',
                                fillColor: Color(0xff323F4B),
                                filled: false,
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Color(0xff323F4B),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffE4E7EB)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(20),
                                )))),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                            controller: passwordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Password';
                              } else
                                return null;
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: 'Password',
                                fillColor: Colors.lightGreen,
                                filled: false,
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Color(0xff323F4B),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(20),
                                )))),
                    SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          login(context);
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                            color: Colors.indigo.shade900,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                            child: Text(
                          'Login',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontFamily: 'Pacifico'),
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child: Text(
                          'Dont have an account?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontFamily: 'Pacifico'),
                        )),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => register()));
                          },
                          child: Text(
                            'Sign Up',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.lightGreen.shade400,
                                fontFamily: 'Pacifico'),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )),
            ),
          ),
        ));
  }
}
