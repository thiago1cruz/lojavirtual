import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/tiles/category_tile.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('product').get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          var dividedTiles = ListTile.divideTiles(
              tiles: snapshot.data!.docs
                  .map((e) => CategoryTile(snapshot: e))
                  .toList(),
              color: Colors.grey[500]);

          return ListView(children: dividedTiles.toList());
        }
      },
    );
  }
}
