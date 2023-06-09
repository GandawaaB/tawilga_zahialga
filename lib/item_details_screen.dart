import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:fluttertoast/fluttertoast.dart";
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
        .then(
          (qS) => qS.docs.forEach(
            (element) {
              element.reference.delete();
              print("deleted favorite data");
            },
          ),
        );
  }

  Future addBasket() async {
    final User? user = FirebaseAuth.instance.currentUser;

    CollectionReference _collectoinRef =
        FirebaseFirestore.instance.collection("users-basket-items");
    return _collectoinRef.doc(user?.email).collection('items').doc().set({
      "itemId": widget.clickItemInfo!.itemID.toString(),
      "itemName": widget.clickItemInfo!.itemName.toString(),
      "itemDescription": widget.clickItemInfo!.itemDescription.toString(),
      "itemImage": widget.clickItemInfo!.itemImage.toString(),
      "itemPrice": widget.clickItemInfo!.itemPrice.toString(),
      "sellerName": widget.clickItemInfo!.sellerName.toString(),
      "sellerPhone": widget.clickItemInfo!.sellerPhone.toString(),
      "publishedDate": DateTime.now(),
      "total": totalNum.toString(),
      "status": "available",
    }).then((value) => print("success added basket"));
  }

  TextEditingController totalNumController = TextEditingController();
  late int totalNum = 1;
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
            Container(
              color: Color.fromARGB(255, 169, 155, 155),
              child: Image.network(
                widget.clickItemInfo!.itemImage.toString(),
                width: MediaQuery.of(context).size.width,
                height: 200,
              ),
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
                  ),),
            ),
            const Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 310),
              child: Divider(
                height: 1,
                color: Colors.black54,
                thickness: 2,
              ),
            ),
            const Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Тоо ширхэг:"),
            ),
            Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    if (totalNum == 1) {
                      return;
                    } else {
                      setState(() {
                        totalNum -= 1;
                      });
                    }
                  },
                  // splashColor: Colors.blue,
                  child: Container(
                    width: 40,
                    height: 40,
                    // color: Colors.amberAccent,
                    child: const Center(
                      child: Text(
                        "-",
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  totalNum.toString(),
                  style: TextStyle(fontSize: 30),
                ),
                // TextField(
                // controller: totalNumController,
                // ),
                InkWell(
                  onTap: () {
                    if (totalNum < 5) {
                      setState(() {
                        totalNum += 1;
                      });
                    }
                    return;
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    // color: Colors.amberAccent,
                    child: Center(
                      child: Text(
                        "+",
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users-basket-items")
                    .doc(FirebaseAuth.instance.currentUser!.email)
                    .collection('items')
                    .where('itemName',
                        isEqualTo: widget.clickItemInfo!.itemName)
                    .snapshots(),
                builder: ((context, snapshot) {
                  if (snapshot.data == null) {
                    return Text("");
                  }
                  return snapshot.data?.docs.length == 0
                      ? TextButton.icon(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.green),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            overlayColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 183, 220, 185)),
                            // padding:
                            //     MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(12)),
                          ),
                          onPressed: () {
                            addBasket();
                          },
                          icon: const Icon(
                            Icons.shopping_basket,
                            // color: Colors.green,
                          ),
                          label: const Text(
                            "САГСЛАХ",
                            // style: TextStyle(color: Colors.green),
                          ),
                        )
                      : TextButton.icon(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.green),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            overlayColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 183, 220, 185)),
                            // padding:
                            //     MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(12)),
                          ),
                          onPressed: () {
                            Fluttertoast.showToast(
                                msg: "Сагсанд нэмэгдсэн бараа байна.");
                          },
                          icon: const Icon(
                            Icons.shopping_basket,
                            // color: Colors.green,
                          ),
                          label: const Text(
                            "САГСЛАХ",
                            // style: TextStyle(color: Colors.green),
                          ),
                        );
                }),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: TextButton.icon(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  overlayColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 220, 183, 183)),
                  // padding:
                  //     MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(12)),
                ),
                onPressed: () {},
                icon: const Icon(
                  Icons.inbox_outlined,
                  // color: Colors.green,
                ),
                label: const Text(
                  "ХУДАЛДАЖ АВАХ",
                  // style: TextStyle(color: Colors.green),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
