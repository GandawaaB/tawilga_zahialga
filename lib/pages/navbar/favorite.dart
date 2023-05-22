import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FavoriteProduct extends StatefulWidget {
  const FavoriteProduct({super.key});

  @override
  State<FavoriteProduct> createState() => _FavoriteProductState();
}

class _FavoriteProductState extends State<FavoriteProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //   body: StreamBuilder<QuerySnapshot>(
    //     stream: FirebaseFirestore.instance
    //         .collection('items')
    //         .orderBy("publishedDate", descending: true)
    //         .snapshots(),
    //     builder: (context, AsyncSnapshot dataSnapshot) {
    //       if (dataSnapshot.hasData) {

    //       }})
    body: Text("Favorite"),

    );  
  }
}
