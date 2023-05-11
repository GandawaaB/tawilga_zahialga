
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>ItemDetailsScreen(widget.itemsInfo)
            ),
          );
        },
        splashColor: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: SizedBox(
            height: 120,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Image.network(
                  widget.itemsInfo!.itemImage.toString(),
                  width: 140,
                  height: 140,
                ),
                const SizedBox(width: 4),
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
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      //seller name
                      Expanded(
                        child: Text(
                          widget.itemsInfo!.sellerName.toString(),
                          maxLines: 2,
                          style: const TextStyle(
                            color: Colors.pinkAccent,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      //show discount badge - 50% off badge
                      // price   - origional  - new price

                      // 50% off badge
                      Row(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.pink,
                            ),
                            alignment: Alignment.topLeft,
                            width: 40,
                            height: 44,
                            child: Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "50%",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  "OFF",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal),
                                ),
                                SizedBox(width: 10),
                              ],
                            )),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //origional price
                              Row(
                                children: [
                                  const Text(
                                    "Origional Price: \$",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  Text(
                                    (double.parse(
                                                widget.itemsInfo!.itemPrice!) +
                                            double.parse(
                                                widget.itemsInfo!.itemPrice!))
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                ],
                              ),
                              // new price
                              Row(
                                children: [
                                  const Text(
                                    "New Price: ",
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
                const Divider(
                  height: 4,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
