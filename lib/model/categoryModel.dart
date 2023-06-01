import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  String? categoryId;
  String? categoryName;
  Timestamp? publishedDate;
  Category({
    this.categoryId,
    this.categoryName,
    this.publishedDate,
  });
  Category.fromJson(Map<String, dynamic> json) {
    categoryId = json["categoryId"];
    categoryName = json["categoryName"];
    publishedDate = json["publishedDate"];
  }
}
