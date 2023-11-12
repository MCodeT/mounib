import 'package:barcode/personnes/model/personne.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PersonneItem extends StatelessWidget {
  const PersonneItem(this.personne, this.reference, {super.key});

  final Personne personne;
  final DocumentReference<Personne> reference;

  /// Returns the personne poster.
  // Widget get poster {
  //   return SizedBox(
  //     width: 100,
  //     child: Image.network(personne.poster),
  //   );
  // }

  /// Returns personne details.
  Widget get details {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          name,
          allergens,
        ],
      ),
    );
  }

  /// Return the personne name.
  Widget get name {
    return Text(
      personne.name,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  /// Returns metadata about the personne.
  // Widget get metadata {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 8),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.only(right: 8),
  //           child: Text('Rated: ${personne.rated}'),
  //         ),
  //         Text('Runtime: ${personne.runtime}'),
  //       ],
  //     ),
  //   );
  // }

  /// Returns a list of allergens personne tags.
  List<Widget> get allergensItems {
    return [
      for (final allergen in personne.allergens)
        Padding(
          padding: const EdgeInsets.only(right: 2),
          child: Chip(
            backgroundColor: Colors.lightBlue,
            label: Text(
              allergen,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
    ];
  }

  Widget get allergens {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Wrap(
        children: allergensItems,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4, top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // poster,
          Flexible(child: details),
        ],
      ),
    );
  }
}
