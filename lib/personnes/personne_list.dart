import 'package:barcode/personnes/personne_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'model/personne.dart';

class PersonneList extends StatefulWidget {
  const PersonneList({Key? key}) : super(key: key);

  @override
  PersonneListState createState() => PersonneListState();
}

class PersonneListState extends State<PersonneList> {
  // PersonneQuery query = PersonneQuery.year;

  final personnesRef = FirebaseFirestore.instance
      .collection('personnes')
      .withConverter<Personne>(
        fromFirestore: (snapshots, _) => Personne.fromJson(snapshots.data()!),
        toFirestore: (personne, _) => personne.toJson(),
      );

  Future<void> addPersonne() {
    return personnesRef
        .add({
          'name': 'touati',
          'userId': 'fdrfds',
          'allergens': ['qdfqds', 'gsdfgdsf', 'gsdfghuoo']
        } as Personne)
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: addPersonne,
      ),
      // appBar: AppBar(
      // title: Column(
      //   mainAxisSize: MainAxisSize.min,
      //   crossAxisAlignment: CrossAxisAlignment.stretch,
      //   children: [
      //     const Text('Membres de la famille'),

      //     // This is a example use for 'snapshots in sync'.
      //     // The view reflects the time of the last Firestore sync; which happens any time a field is updated.
      //     StreamBuilder(
      //       stream: FirebaseFirestore.instance.snapshotsInSync(),
      //       builder: (context, _) {
      //         return Text(
      //           'Latest Snapshot: ${DateTime.now()}',
      //           style: Theme.of(context).textTheme.bodySmall,
      //         );
      //       },
      //     ),
      //   ],
      // ),
      // actions: <Widget>[
      // PopupMenuButton<PersonneQuery>(
      //   onSelected: (value) => setState(() => query = value),
      //   icon: const Icon(Icons.sort),
      //   itemBuilder: (BuildContext context) {
      //     return [
      //       const PopupMenuItem(
      //         value: PersonneQuery.year,
      //         child: Text('Sort by Year'),
      //       ),
      //       const PopupMenuItem(
      //         value: PersonneQuery.score,
      //         child: Text('Sort by Score'),
      //       ),
      //       const PopupMenuItem(
      //         value: PersonneQuery.likesAsc,
      //         child: Text('Sort by Likes ascending'),
      //       ),
      //       const PopupMenuItem(
      //         value: PersonneQuery.likesDesc,
      //         child: Text('Sort by Likes descending'),
      //       ),
      //       const PopupMenuItem(
      //         value: PersonneQuery.fantasy,
      //         child: Text('Filter genre Fantasy'),
      //       ),
      //       const PopupMenuItem(
      //         value: PersonneQuery.sciFi,
      //         child: Text('Filter genre Sci-Fi'),
      //       ),
      //     ];
      //   },
      // ),
      // PopupMenuButton<String>(
      //   onSelected: (_) => _resetLikes(),
      //   itemBuilder: (BuildContext context) {
      //     return [
      //       const PopupMenuItem(
      //         value: 'reset_likes',
      //         child: Text('Reset like counts (WriteBatch)'),
      //       ),
      //     ];
      //   },
      // ),
      // ],
      // ),
      body: StreamBuilder<QuerySnapshot<Personne>>(
        stream: personnesRef.snapshots(),
        /* queryBy(query).snapshots(), */
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.requireData;

          return ListView.builder(
            itemCount: data.size,
            itemBuilder: (context, index) {
              return PersonneItem(
                data.docs[index].data(),
                data.docs[index].reference,
              );
            },
          );
        },
      ),
    );
  }

  // Future<void> _resetLikes() async {
  //   final personnes = await personnesRef.get();
  //   WriteBatch batch = FirebaseFirestore.instance.batch();

  //   for (final personne in personnes.docs) {
  //     batch.update(personne.reference, {'likes': 0});
  //   }
  //   await batch.commit();
  // }
}
