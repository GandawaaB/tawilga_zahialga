import 'package:cloud_firestore/cloud_firestore.dart';

class ItemsFavorite {
  String? itemID;
  String? itemName;
  String? itemDescription;
  String? itemImage;
  String? itemPrice;
  Timestamp? publishedDate;
  String? status;
  ItemsFavorite({
    this.itemID,
    this.itemName,
    this.itemDescription,
    this.itemImage,
    this.itemPrice,
    this.publishedDate,
    this.status,
  });

  ItemsFavorite.fromJson(Map<String, dynamic>json){
    itemID = json["itemId"];
    itemName = json["itemName"];
    itemDescription = json["itemDescription"];
    itemImage = json["itemImage"];
    itemPrice = json["itemPrice"];
    publishedDate = json["publishedDate"];
    status = json["status"];
  }
}
