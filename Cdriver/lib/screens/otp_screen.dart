import 'dart:async';
import 'package:app/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'home_screen.dart';

class otpscreen extends StatefulWidget {
  const otpscreen({super.key});

  @override
  State<otpscreen> createState() => _otpscreenState();
}

class _otpscreenState extends State<otpscreen> {
  // editing controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  // form key
  final _formKey = GlobalKey<FormState>();

  final auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;

  @override
  void initState() {
    var user = auth.currentUser;
    user!.sendEmailVerification();

    timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final verifyOtp = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Colors.lightBlue,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            checkEmailVerified();

            showDialog(
              context: context,
              builder: (context) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.lightBlue,
                ));
              },
            );
          },
          child: const Text(
            "Verify Email",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
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
            Navigator.of(context).pop(const LoginScreen());
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
                    Lottie.asset('assets/images/otp.json',
                        width: 200, height: 200, fit: BoxFit.fill),
                    Text(
                      'Verification',
                      style: GoogleFonts.poppins(
                          fontSize: 34, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 15),
                    // emailField,
                    // SizedBox(height: 25),
                    verifyOtp,
                    const SizedBox(
                      height: 25,
                    ),
                    const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Note: ",
                            style: TextStyle(
                                color: Colors.lightBlue,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          Text("Please check your spam folder"),
                        ])
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    var user = auth.currentUser!;
    await user.reload();

    if (user.emailVerified) {
      timer.cancel();
      Navigator.of(context).pop;
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()));
      Fluttertoast.showToast(msg: "Verification Successful");
    }
  }
}
