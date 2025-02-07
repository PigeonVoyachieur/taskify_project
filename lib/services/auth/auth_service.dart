import 'package:firebase_auth/firebase_auth.dart';

/*

Auth Service Firebase

Gère l'authentification des utilisateurs dans Firebase auth

------------------------------------

Permet:
- Connexion
- Déconnexion
- Création d'un compte

*/

class AuthService{
// Récupérer l'instance du auth
final _auth = FirebaseAuth.instance;

// Récupérer l'utilisateur actuel et son uid
User? getCurrentUser() => _auth.currentUser;
String getCurrentUid() => _auth.currentUser!.uid;

// Connexion par email et mot de passe
Future<UserCredential> loginEmailPassword(String email, password) async {
  // Tentative de connexion
  try{
    final UserCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return UserCredential;

  // On récupère les erreurs
  } on FirebaseAuthException catch(e) {
    throw Exception(e.code);
  }
}

// Déconnexion
Future<void> logout() async {
  await _auth.signOut();
}

// Création du compte
Future<UserCredential> registerEmailPassword(String email, password) async {
  try{
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
    );
    return userCredential;
  } on FirebaseAuthException catch(e) {
    throw Exception(e.code);
  }
}

}