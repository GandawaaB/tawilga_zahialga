import "package:flutter/material.dart";

import "../item_details_screen.dart";
import "../model/items.dart";


class FavoriteWidget extends StatefulWidget {
  
  Items? itemsInfo;
  BuildContext? context;
  FavoriteWidget(this.itemsInfo, this.context);

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Expanded(
                    // child:]
                    
                    //
                    Image.network(
    
                      widget.itemsInfo!.itemImage.toString(),
                      width: 140,
                      height: 140,
                    
                    ),
                  
    
                    // const SizedBox(width: 4),
                    Expanded(
                      
                      child: Container(
                        color: Color.fromARGB(255, 243, 242, 239),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // const SizedBox(
                              //   height: 10,
                              // ),
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
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}