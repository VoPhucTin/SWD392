import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:swd_project/services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swd_project/login.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.network("${FirebaseAuth.instance.currentUser!.photoURL}"),
          Text("${FirebaseAuth.instance.currentUser!.displayName}"),
          Text("${FirebaseAuth.instance.currentUser!.email}"),
          ElevatedButton(
              onPressed: () async {
                await FirebaseServices().signOut();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
              child: Text('Logout')),
        ]),
      ),
    );
  }
}
