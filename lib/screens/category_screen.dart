import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/data/product_data.dart';
import 'package:lojavirtual/tiles/product_tiles.dart';

class CategoryScreen extends StatelessWidget {
  final DocumentSnapshot snapshot;

  const CategoryScreen({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text(snapshot.get('title')),
            centerTitle: true,
            bottom: const TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                    icon: Icon(
                  Icons.grid_on,
                )),
                Tab(
                    icon: Icon(
                  Icons.view_list,
                ))
              ],
            ),
          ),
          body: FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance
                .collection('product')
                .doc(snapshot.id)
                .collection('items')
                .get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    GridView.builder(
                        padding: const EdgeInsets.all(4.0),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 4,
                                crossAxisSpacing: 4,
                                childAspectRatio: 0.65),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return ProductTile(
                              type: 'grid',
                              data: ProductData.fromDocument(
                                  snapshot.data!.docs[index]));
                        }),
                    ListView.builder(
                        padding: const EdgeInsets.all(4.0),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return ProductTile(
                              type: 'list',
                              data: ProductData.fromDocument(
                                  snapshot.data!.docs[index]));
                        })
                  ],
                );
              }
            },
          )),
    );
  }
}
