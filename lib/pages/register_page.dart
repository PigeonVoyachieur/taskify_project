import 'package:flutter/material.dart';
import '../components/my_button.dart';
import '../components/my_text_field.dart';
import '../database/database_service.dart';
import '../services/auth/auth_service.dart';

/*

Page d'inscription

Formulaire permettant de créer un compte utilisateur

--------------------------------------------------------

On a besoin de :
- nom
- email
- mot de passe
- confirmation du mot de passe

*/

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = AuthService();
  final _db = DatabaseService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  void register() async{
    if(passwordController.text == confirmPasswordController.text){
      try{

        await _auth.registerEmailPassword(
          emailController.text,
          passwordController.text,
        );

        await _db.saveUserInfoInFirebase(
          name: nameController.text,
          email: emailController.text,
        );
      } catch(e){
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
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
              "Les mots de passe ne sont pas les mêmes"
          ),
        ),
      );
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
            "Créez votre compte",
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16
            ),
          ),

          //   Champ nom
          MyTextField(
              controller: nameController,
              hintText: 'Saisissez votre nom',
              obscureText: false
          ),

          const SizedBox(height: 5),

          //   Champ email
          MyTextField(
              controller: emailController,
              hintText: 'Saisissez votre email',
              obscureText: false
          ),

          const SizedBox(height: 5),

          //   Champ mot de passe
          MyTextField(
              controller: passwordController,
              hintText: 'Saisissez votre mot de passe...',
              obscureText: true
          ),

          const SizedBox(height: 5),

          //   Champ confirmation mot de passe
          MyTextField(
              controller: confirmPasswordController,
              hintText: 'Confirmez votre mot de passe...',
              obscureText: true
          ),

          const SizedBox(height: 15),

          //   Bouton d'action créez le compte
          MyButton(
            text: "Créez le compte",
            onTap: register,
          ),

          const SizedBox(height: 15),

          //   Lien vers la page connexion
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
                  "Connectez-vous!",
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
