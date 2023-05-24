import 'package:flutter/material.dart';
import 'package:furniture_app/model/items.dart';

import '../item_details_screen.dart';
import '../model/itemsFavorite.dart';

class FavoriteListItemWidget extends StatelessWidget {
  Items? favoriteItem;
  BuildContext? context;

  FavoriteListItemWidget({this.favoriteItem, this.context});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        child: Card(
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute( builder: (context) => ItemDetailsScreen(favoriteItem)));
            },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image(
                    image: NetworkImage(favoriteItem!.itemImage.toString()),
                    fit: BoxFit.cover,
                    width: 150,
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
                        favoriteItem!.itemName.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        favoriteItem!.itemDescription.toString(),
                        // style: TextStyle(),
                      ),
                    ],
                  ),
                ),
                // IconButton(
                //   onPressed: () {},
                //   icon: const Icon(Icons.delete),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
