import 'package:app/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  User? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() {
      _isLoading = true;
    });

    // Fetch user data
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      _user = user;
      _isLoading = false;
    });
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        automaticallyImplyLeading: false, // This removes the back button
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _user == null
                    ? Center(
                        child: Text(
                          'You are not logged in.',
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.red,
                          ),
                        ),
                      )
                    : ListView(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'My account',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ListTile(
                                  title: const Text('Name'),
                                  subtitle: Text(_user?.displayName ?? 'N/A'),
                                  onTap: () {
                                    // Navigate to edit name screen
                                  },
                                ),
                                ListTile(
                                  title: const Text('Username'),
                                  subtitle: Text(_user?.email ?? 'N/A'),
                                  onTap: () {
                                    // Navigate to edit username screen
                                  },
                                ),
                                ListTile(
                                  title: const Text('Email'),
                                  subtitle: Text(_user?.email ?? 'N/A'),
                                  onTap: () {
                                    // Navigate to edit email screen
                                  },
                                ),
                                // Add more ListTiles as needed
                                const SizedBox(height: 20),
                                const Text(
                                  'Notifications',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ListTile(
                                  title: const Text('Bus updates'),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  onTap: () {
                                    // Navigate to bus updates settings screen
                                  },
                                ),
                                ListTile(
                                  title: const Text('Promotions'),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  onTap: () {
                                    // Navigate to promotions settings screen
                                  },
                                ),
                                ListTile(
                                  title: const Text('Safety and security'),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  onTap: () {
                                    // Navigate to safety and security settings screen
                                  },
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Support',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ListTile(
                                  title: const Text('I need help'),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  onTap: () {
                                    // Navigate to help screen
                                  },
                                ),
                                ListTile(
                                  title: const Text('I have a safety concern'),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  onTap: () {
                                    // Navigate to safety concern screen
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: TextButton.icon(
                onPressed: _logout,
                icon: const Icon(Icons.logout, color: Colors.red),
                label: Text(
                  'Logout',
                  style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.red),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
