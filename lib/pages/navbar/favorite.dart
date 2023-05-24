import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/model/items.dart';

import '../../item_details_screen.dart';

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
      // body:
      // StreamBuilder<QuerySnapshot>(
      //   stream: FirebaseFirestore.instance
      //       .collection('users-favorite-items')
      //       .doc(user!.email).collection('items')
      //       .orderBy("publishedDate", descending: true)
      //       .snapshots(),
      //   builder: (context, AsyncSnapshot dataSnapshot) {
      //     if (dataSnapshot.hasData) {
      //       return Text("");
      //     }else{
      //       Text("");
      //     }
      //   },
      // ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: Card(
            child: InkWell(
              onTap: () {
                // Navigator.push(context, MaterialPageRoute( builder: (context) => ItemDetailsScreen(widget.itemsInfo)));
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/profileIMG.png",
                      width: 70,
                      height: 70,
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Sofa brown",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "New design. Luxury Elegant tufted sofa set living room.",
                          style: TextStyle(),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
