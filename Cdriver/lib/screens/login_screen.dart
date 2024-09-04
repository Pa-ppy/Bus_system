import 'dart:async';
import 'package:app/model/routes.dart';
import 'package:app/model/shared_preference.dart';
import 'package:app/screens/otp_screen.dart';
import 'package:app/screens/registration_screen.dart';
import 'package:app/screens/scaffolds/screen_scaffold.dart';
import 'package:app/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'Forgot_Password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // form key
  final _formKey = GlobalKey<FormState>();

  // editing controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // firebase
  final auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;

  // string for displaying the error Message
  String? errorMessage;

  bool _obscureText = true;

  final PrefService _prefService = PrefService();

  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        autofillHints: const [AutofillHints.email],
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          else if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: _obscureText,
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        } else if (!regex.hasMatch(value)) {
          return ("Enter Valid Password(Min. 6 Character)");
        }
        return null;
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.vpn_key),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Colors.blue,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            signIn(emailController.text, passwordController.text);
          },
          child: const Text(
            "Login",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return WillPopScope(
      onWillPop: () async {
        return await Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const WelcomeScreen()));
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              // passing this to our root
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const WelcomeScreen()));
            },
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Lottie.asset('assets/images/user.json',
                          width: 100, height: 100, fit: BoxFit.fill),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Welcome Back',
                        style: GoogleFonts.poppins(
                            fontSize: 34, fontWeight: FontWeight.w700),
                      ),

                      // SizedBox(
                      //     height: 200,
                      //     child: Image.asset(
                      //       "assets/logo.png",
                      //       fit: BoxFit.contain,
                      //     )),
                      const SizedBox(height: 25),
                      emailField,
                      const SizedBox(height: 25),
                      passwordField,
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ForgotPassword()));
                                },
                                child: Container(
                                  child: const Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.lightBlue,
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      loginButton,
                      const SizedBox(height: 15),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text("Don't have an account? "),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegistrationScreen()));
                              },
                              child: const Text(
                                "Register",
                                style: TextStyle(
                                    color: Colors.lightBlue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            )
                          ])
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // login function
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) async => {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: Colors.lightBlue,
                      ));
                    },
                  ),
                  await _prefService.createCache(
                      emailController.text, passwordController.text),
                  user = auth.currentUser!,
                  await user.reload(),
                  if (user.emailVerified)
                    {
                      Navigator.of(context).pop(),
                      Navigator.of(context).pop(),
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const ScreenScaffold()))
                    }
                  else
                    {
                      Navigator.of(context).pop(),
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const otpscreen()))
                    }
                });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Navigator.of(context).pop;
        Navigator.of(context).pushReplacementNamed(loginRoute);
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
}
