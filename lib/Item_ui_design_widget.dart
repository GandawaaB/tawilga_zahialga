import 'package:flutter/material.dart';
import 'package:furniture_app/item_details_screen.dart';
import 'model/items.dart';

class ItemUIDesignWidget extends StatefulWidget {
  Items? itemsInfo;
  BuildContext? context;
  ItemUIDesignWidget(this.itemsInfo, this.context);

  @override
  State<ItemUIDesignWidget> createState() => _ItemUIDesignWidgetState();
}

class _ItemUIDesignWidgetState extends State<ItemUIDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          print(widget.itemsInfo!.itemImage.toString());
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ItemDetailsScreen(widget.itemsInfo)),
          );
        },
        splashColor: Colors.blue,
        child: SizedBox(
          height: 120,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              // Expanded(
              // child:]
              
              //
              // Image.network(

              //   widget.itemsInfo!.itemImage.toSwtring(),
              //   width: 140,
              //   height: 140,
              
              // ),
            

              // const SizedBox(width: 4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    //item name
                    Expanded(
                      child: Text(
                        widget.itemsInfo!.itemName.toString(),
                        maxLines: 2,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // const SizedBox(height: 5),
                    //seller name
                    // Expanded(
                    //   child: Text(
                    //     widget.itemsInfo!.sellerName.toString(),
                    //     maxLines: 2,
                    //     style: const TextStyle(
                    //       color: Colors.pinkAccent,
                    //       fontSize: 16,
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 5),

                    Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Price: ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                const Text(
                                  "\$",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.red,
                                  ),
                                ),
                                Text(
                                  double.parse(widget.itemsInfo!.itemPrice!)
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
