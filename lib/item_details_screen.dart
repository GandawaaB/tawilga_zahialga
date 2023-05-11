import "package:flutter/material.dart";
import "package:furniture_app/virtual_ar_view_screen.dart";
import 'model/items.dart';

class ItemDetailsScreen extends StatefulWidget {
  Items? clickItemInfo;
  ItemDetailsScreen(this.clickItemInfo);

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: Text(
          widget.clickItemInfo!.itemName.toString(),
        ),
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
