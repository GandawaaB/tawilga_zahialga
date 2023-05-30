import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/model/items.dart';

import '../item_details_screen.dart';
import '../model/itemsBasket.dart';

class FavoriteListItemWidget extends StatefulWidget {
  Items? favoriteItem;
  BuildContext? context;

  FavoriteListItemWidget({this.favoriteItem, this.context});

  @override
  State<FavoriteListItemWidget> createState() => _FavoriteListItemWidgetState();
}

class _FavoriteListItemWidgetState extends State<FavoriteListItemWidget> {
  Future deleteFavotite() async {
    final User? user = FirebaseAuth.instance.currentUser;
    CollectionReference _collectoinRef =
        FirebaseFirestore.instance.collection("users-favorite-items");
    return _collectoinRef
        .doc(user!.email)
        .collection('items')
        .where('itemName', isEqualTo: widget.favoriteItem?.itemName)
        .get()
        .then(
          (qS) => qS.docs.forEach(
            (element) {
              element.reference.delete();
              print("deleted favorite data");
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:10, ),
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        child: Card(
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ItemDetailsScreen(widget.favoriteItem)));
            },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image(
                    image:
                        NetworkImage(widget.favoriteItem!.itemImage.toString()),
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.favoriteItem!.itemName.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.favoriteItem!.itemDescription.toString(),
                        // style: TextStyle(),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    deleteFavotite();
                  },
                  icon: const Icon(
                    Icons.favorite,
                    color: Color.fromARGB(255, 138, 65, 60),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
