import 'package:flutter/material.dart';

import '../services/auth/auth_service.dart';
import 'my_drawer_tile.dart';

/*

MENU  DRAWER

Un menu accessible par un bouton en déplayant
une navigation latérale

------------------------------------------------------------------

Les options du menu sont:

-Acceuil
-Switch lightMode / DarkMode
-Déconnexion

*/


class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  // auth service
  final _auth = AuthService();

  // fonction déconnexion
  void logout(){
    _auth.logout();
  }

  // Affichage UI
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,

      // Icone (logo)
      child: SafeArea(
        child: Column(
          children: [
            Padding(padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Icon(
                Icons.person,
                size: 72,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Divider(
              indent: 25,
              endIndent: 25,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(
              height: 10,
            ),

            // Tiles
            // Accueil
            MyDrawerTile(
              title: "Accueil",
              icon: Icons.home,
              onTap: () {
                Navigator.pop(context);
              },
            ),

            // Paramètres
            MyDrawerTile(
              title: "Changer de mode",
              icon: Icons.settings,
              onTap: () {},
            ),
            // Déconnexion
            MyDrawerTile(
              title: "Déconnexion",
              icon: Icons.logout,
              onTap: logout,
            ),
          ],
        ),
      ),
    );
  }
}
