import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
// import "package:furniture_app/model/items.dart";
import "package:furniture_app/model/itemsBasket.dart";

class BasketWidget extends StatefulWidget {
  ItemsBasket? basketItem;
  BuildContext? context;
  BasketWidget({this.basketItem, this.context});

  @override
  State<BasketWidget> createState() => _BasketWidgetState();
}

class _BasketWidgetState extends State<BasketWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 130,
        child: Card(
          child: InkWell(
            onTap: () {},
            child: Row(
              children: [
                Image(
                  image: NetworkImage(widget.basketItem!.itemImage.toString()),
                  
                  width: 125,
                  height: 100,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.basketItem!.itemName.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "\$${widget.basketItem!.itemPrice.toString()}",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 255, 81, 7),
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            "Тоо ширхэг: ",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black38),
                          ),
                          Text(
                            widget.basketItem!.total.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.amber),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    deleteBasket();
                  },
                  icon: Icon(
                    Icons.delete_outline,
                    color: Colors.brown,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future deleteBasket() async {
    final User? user = FirebaseAuth.instance.currentUser;
    CollectionReference _collectoinRef =
        FirebaseFirestore.instance.collection("users-basket-items");
    return _collectoinRef
        .doc(user!.email)
        .collection('items')
        .where('itemName', isEqualTo: widget.basketItem?.itemName)
        .get()
        .then(
          (qS) => qS.docs.forEach(
            (element) {
              element.reference.delete();
              print("deleted basket data");
            },
          ),
        );
  }
}
