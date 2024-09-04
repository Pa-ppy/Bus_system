import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app/model/routes.dart';
import 'package:app/screens/welcome_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  FirebaseDatabase database = FirebaseDatabase.instance;

  // string for displaying the error message
  String? errorMessage;

  bool _obscureText = true;
  bool _confirmObscureText = true;

  // our form key
  final _formKey = GlobalKey<FormState>();

  // editing Controllers
  final fullnameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();
  final fullNameEditingController = TextEditingController();
  final busEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Full name field
    final fullnameField = TextFormField(
      autofocus: false,
      controller: fullnameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return "Full Name cannot be Empty";
        }
        if (!regex.hasMatch(value)) {
          return "Enter Valid name (Min. 3 Characters)";
        }
        return null;
      },
      onSaved: (value) {
        fullnameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.account_circle),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Full Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    // Email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter Your Email";
        }
        // Reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\\.[a-z]")
            .hasMatch(value)) {
          return "Please Enter a valid email";
        }
        return null;
      },
      onSaved: (value) {
        emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.mail),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    // Password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: _obscureText,
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return "Password is required";
        }
        if (!regex.hasMatch(value)) {
          return "Enter Valid Password (Min. 6 Characters)";
        }
        return null;
      },
      onSaved: (value) {
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
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

    // Confirm password field
    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPasswordEditingController,
      obscureText: _confirmObscureText,
      validator: (value) {
        if (value!.isEmpty) {
          return "Confirm Password is required";
        }
        if (confirmPasswordEditingController.text !=
            passwordEditingController.text) {
          return "Passwords don't match";
        }
        return null;
      },
      onSaved: (value) {
        confirmPasswordEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.vpn_key),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Confirm Password",
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _confirmObscureText = !_confirmObscureText;
            });
          },
          child: Icon(
            _confirmObscureText ? Icons.visibility : Icons.visibility_off,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    // Sign up button
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Colors.lightBlue,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signUp(emailEditingController.text, passwordEditingController.text);
        },
        child: const Text(
          "Sign Up",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
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
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const WelcomeScreen()),
            );
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Lottie.asset(
                      'assets/images/sign-up.json',
                      width: 140,
                      height: 140,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Registration',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 34,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 45),
                    fullnameField,
                    const SizedBox(height: 20),
                    emailField,
                    const SizedBox(height: 20),
                    passwordField,
                    const SizedBox(height: 20),
                    confirmPasswordField,
                    const SizedBox(height: 20),
                    signUpButton,
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text("Already registered? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                            );
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.lightBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
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
      ),
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.lightBlue),
          );
        },
      );

      try {
        await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
        User? user = _auth.currentUser;

        // Generate unique driver ID
        String driverID = await generateDriverID();

        // Get current location (optional, you can decide when to get location)
        Position position = await _getCurrentLocation();

        // Store user details including driver ID and location in Firestore
        firebaseFirestore.collection("drivers").doc(user!.uid).set({
          'fullName': fullNameEditingController.text,
          'email': emailEditingController.text,
          'driverID': driverID, // Store the unique driver ID
          'location': GeoPoint(
              position.latitude, position.longitude), // Store initial location
          'bus': busEditingController.text,
        });

        Navigator.of(context).pop(); // Close progress indicator
        Fluttertoast.showToast(msg: "Account created successfully");
        Navigator.of(context).pushReplacementNamed(loginRoute);
      } on FirebaseAuthException catch (error) {
        Navigator.of(context).pop(); // Close progress indicator
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
        Fluttertoast.showToast(msg: errorMessage!);
      }
    }
  }

  Future<String> generateDriverID() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    // Fetch all drivers to determine the next driver ID
    QuerySnapshot driversSnapshot =
        await firebaseFirestore.collection('drivers').get();
    int driverCount = driversSnapshot.docs.length;

    // Generate the new driver ID
    int newIDNumber = driverCount + 1;
    String driverID = 'D${newIDNumber.toString().padLeft(3, '0')}';

    return driverID;
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    // Get the current location
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
