import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskify_project/pages/home_page.dart';

import 'login_or_register.dart';


/*

Auth Gate

Permet de vérifier si l'utilisateur est connecter ou non

------------------------------------------------------

Si connecté => rediriger vers la Home Page
Si non connecté => rediriger vers le login

*/

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (context, snapshot) {
        if(snapshot.hasData){
          return const HomePage();
        } else {
          return LoginOrRegister();
        }
      }),
    );
  }
}
