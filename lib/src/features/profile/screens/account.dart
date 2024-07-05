import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guardiancare/src/constants/colors.dart';
import 'package:guardiancare/src/features/authentication/screens/loginPage.dart';
import 'package:guardiancare/src/features/emergency/screens/emergencyContactPage.dart';
import 'package:guardiancare/src/features/report/screens/reportPage.dart';
import 'package:guardiancare/src/features/authentication/controllers/login_controller.dart';

class Account extends StatelessWidget {
  final User? user;

  const Account({super.key, this.user});

  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: user?.photoURL != null
                    ? NetworkImage(user!.photoURL!)
                    : null,
                child:
                    user?.displayName != null && user!.displayName!.isNotEmpty
                        ? Text(user!.displayName![0].toUpperCase())
                        : null,
              ),
              const SizedBox(height: 10),
              const Text(
                'Profile Information',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(Icons.person, color: tPrimaryColor),
                title: Text('Name: ${user?.displayName ?? 'Not available'}'),
              ),
              ListTile(
                leading: const Icon(Icons.email, color: tPrimaryColor),
                title: Text('Email: ${user?.email ?? 'Not available'}'),
              ),
              const Divider(),
              const Text(
                'Child Safety Settings',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.phone, color: tPrimaryColor),
                title: const Text('Emergency Contact'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmergencyContactPage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.warning, color: tPrimaryColor),
                title: const Text('Report an Incident'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ReportPage(),
                    ),
                  );
                },
              ),
              const Divider(),
              const Text(
                'Settings',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: tPrimaryColor),
                title: const Text('Log Out'),
                onTap: () async {
                  bool result = await signOutFromGoogle();
                  print(result);

                  Navigator.pop(
                    // ignore: use_build_context_synchronously
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );

                  if (result) print("Signed Out Successfully !!");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
