/*

Modèle de données d'un utilisateur

--------------------------------------------------

Un utilisateur est composé de :

- uid
- nom
- email
- pseudo
- biographie
- photo de profile

*/

import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile{
  final String uid;
  final String name;
  final String email;

  UserProfile({
    required this.uid,
    required this.name,
    required this.email,
  });

  // conversion d(un document firestore en modèle de données User
  factory UserProfile.fromDocument(DocumentSnapshot doc){
    return UserProfile(
      uid: doc['uid'],
      name: doc['name'],
      email: doc['email'],
    );
  }

//   conversion d'un modèle de données User en document Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
    };
  }
}