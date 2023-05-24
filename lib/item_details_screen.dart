// ignore_for_file: must_be_immutable

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:furniture_app/virtual_ar_view_screen.dart";
// import "package:http/http.dart";
import 'model/items.dart';

class ItemDetailsScreen extends StatefulWidget {
  Items? clickItemInfo;
  ItemDetailsScreen(this.clickItemInfo);

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  Future addFavorite() async {
    final User? user = FirebaseAuth.instance.currentUser;
    CollectionReference _collectoinRef =
        FirebaseFirestore.instance.collection("users-favorite-items");
    // print(widget.clickItemInfo!.itemID.toString());

    return _collectoinRef.doc(user?.email).collection('items').doc().set({
      "itemId": widget.clickItemInfo!.itemID.toString(),
      "itemName": widget.clickItemInfo!.itemName.toString(),
      "itemDescription": widget.clickItemInfo!.itemDescription.toString(),
      "itemImage": widget.clickItemInfo!.itemImage.toString(),
      "itemPrice": widget.clickItemInfo!.itemPrice.toString(),
      "sellerName": widget.clickItemInfo!.sellerName.toString(),
      "sellerPhone": widget.clickItemInfo!.sellerPhone.toString(),
      "publishedDate": DateTime.now(),
      "status": "available",
    }).then((value) => print("success added favorite product "));
  }

  Future deleteFavotite() async {
    final User? user = FirebaseAuth.instance.currentUser;
    CollectionReference _collectoinRef =
        FirebaseFirestore.instance.collection("users-favorite-items");
    return _collectoinRef
        .doc(user!.email)
        .collection('items')
        .where('itemName', isEqualTo: widget.clickItemInfo!.itemName)
        .get()
        .then((qS) => qS.docs.forEach((element) {
              element.reference.delete();
              print("deleted favorite data");
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: Text(
          widget.clickItemInfo!.itemName.toString(),
        ),
        actions: [
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users-favorite-items")
                  .doc(FirebaseAuth.instance.currentUser!.email)
                  .collection('items')
                  .where('itemName', isEqualTo: widget.clickItemInfo!.itemName)
                  .snapshots(),
              builder: ((context, snapshot) {
                if (snapshot.data == null) {
                  return Text("");
                }
                return IconButton(
                  onPressed: () {
                    snapshot.data?.docs.length == 0
                        ? addFavorite()
                        : deleteFavotite();
                  },
                  icon: snapshot.data?.docs.length == 0
                      ? const Icon(Icons.favorite)
                      : const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                );
              }))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.black12,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (c) => VirtualARViewScreen(
                        widget.clickItemInfo!.itemImage.toString(),
                      )));
        },
        label: const Text(" AR турших"),
        icon: const Icon(
          Icons.mobile_screen_share_rounded,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.clickItemInfo!.itemImage.toString(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 8),
              child: Text(
                widget.clickItemInfo!.itemName.toString(),
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 8),
              child: Text(
                widget.clickItemInfo!.itemDescription.toString(),
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(widget.clickItemInfo!.itemPrice.toString() + ("\$"),
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  )),
            ),
            const Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 310),
              child: Divider(
                height: 1,
                color: Colors.black54,
                thickness: 2,
              ),
            )
          ],
        ),
      )),
    );
  }
}
