import 'package:flutter/material.dart';

/*

Drawer Tile est une case pour chaque éléments du menu drawer

-------------------------------------------------------------

Dans chaque tile on a:
-Titre
-Icone
-fonction

*/

class MyDrawerTile extends StatelessWidget {
  // Déclaration des variables
  final String title;
  final IconData icon;
  final void Function()? onTap;

  // Constructeur
  const MyDrawerTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  // Affichage UI
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
      ),
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.primary,
      ),
      onTap: onTap,
    );
  }
}
