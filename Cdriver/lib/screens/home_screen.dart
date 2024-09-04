import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app/model/shared_preference.dart';
import 'package:app/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  final PrefService _prefService = PrefService();

  Future<bool?> _onBackPressed() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Do you want to exit?'),
            actions: <Widget>[
              TextButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: const Text('Yes'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                  SystemNavigator.pop();
                },
              ),
            ],
          );
        });
  }

  final Stream<QuerySnapshot> users =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool result = await _onBackPressed() ?? false;
        return result;
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
              _onBackPressed();
            },
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150,
                  child: Image.asset("assets/images/logo.png",
                      fit: BoxFit.contain),
                ),
                const Text(
                  "Welcome Back",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 250,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: StreamBuilder<QuerySnapshot>(
                      stream: users,
                      builder: (
                        BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot,
                      ) {
                        if (snapshot.hasError) {
                          return const Text('Something went wrong.');
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text('Loading');
                        }
                        final data = snapshot.requireData;

                        return ListView.builder(
                            itemCount: data.size,
                            itemBuilder: (context, index) {
                              return Text(
                                  '${data.docs[index]['fullName']} ${data.docs[index]['email']}');
                            });
                      }),
                ),
                const SizedBox(
                  height: 15,
                ),
                ActionChip(
                    label: const Text("Logout"),
                    onPressed: () async {
                      await _prefService
                          .removeCache("email", "fullName")
                          .whenComplete(() {
                        logout(context);
                      });
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
