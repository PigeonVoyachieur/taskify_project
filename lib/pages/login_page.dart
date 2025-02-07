import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/my_text_field.dart';
import '../services/auth/auth_service.dart';

/*

Page de connexion
Un utilisateur existant peut se connecter avec

- email
- mot de passe

------------------------------------------------------------

Si l'utilisateur est authenetifié => redirection vers Home Page
Si l'utilisateur n'existe pas encore => affiche un lien qui redirige vers la page de création du compte (Register Page)

*/

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // auth Service
  final _auth = AuthService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() async {
    try{
      // on essaie de se connecter avec les infos données
      await _auth.loginEmailPassword(emailController.text, passwordController.text);

    } catch(e) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                title: Text(e.toString()),
              ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          // Logo
          Icon(
            Icons.lock_open_rounded,
            size: 60,
            color: Theme.of(context).colorScheme.primary,
          ),

          const SizedBox(height: 15),

          // Message de bienvenue
          Text(
            "Nous sommes heureux de vous revoir !",
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16
            ),
          ),

          //   Champ email
          MyTextField(
              controller: emailController,
              hintText: 'Saisissez votre email',
              obscureText: false
          ),
          //   Champ mot de passe
          MyTextField(
              controller: passwordController,
              hintText: 'Saisissez votre mot de passe',
              obscureText: true
          ),

          const SizedBox(height: 15),

          // Mot de passe oublié
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "Mot de passe oublié ?",
              style: TextStyle(color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 15),

          //   Bouton d'action Connexion
          MyButton(
            text: "Connexion",
            onTap: login,
          ),

          const SizedBox(height: 15),

          //   Lien vers la register page Créer un compte
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Pas encore de compte ?",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),

              const SizedBox(width: 5,),

              GestureDetector(
                onTap: widget.onTap,
                child: Text(
                  "Créez un compte !",
                  style: TextStyle(color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}