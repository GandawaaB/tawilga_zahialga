import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/model/items.dart';
import '../../widgets/favoriteListWidget.dart';

class FavoriteProduct extends StatefulWidget {
  const FavoriteProduct({super.key});
  // FavoriteProduct({this.itemsInfo});
  // Items? itemsInfo;

  @override
  State<FavoriteProduct> createState() => _FavoriteProductState();
}

class _FavoriteProductState extends State<FavoriteProduct> {
  final User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users-favorite-items')
            .doc(user!.email)
            .collection('items')
            .orderBy("publishedDate", descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot dataSnapshot) {
          if (dataSnapshot.hasData) {
            // return
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Хадгалсан бараанууд:",
                    style: TextStyle(fontSize: 20, color: Colors.black38),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    // margin: EdgeInsets.only(top: 10),
                    height: 600,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 0.3),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        )),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 14,
                        ),
                        Container(
                          height:570,
                          child: ListView.builder(
                            itemCount: dataSnapshot.data!.docs.length,
                            itemBuilder: (context, i) {
                              Items eachIteminfo = Items.fromJson(
                                  dataSnapshot.data!.docs[i].data()
                                      as Map<String, dynamic>);

                              return FavoriteListItemWidget(
                                favoriteItem: eachIteminfo,
                                context: context,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Text("");
          }
        },
      ),
    );
  }
}
