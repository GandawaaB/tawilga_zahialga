import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String? userID;
  String? userName;
  String? password;
  String? phoneNumber;
  Timestamp? publishedDate;
  String? status;
  Users({
    this.userID,
    this.userName,
    this.password,
    this.phoneNumber,
    this.publishedDate,
    this.status,
  });

  Users.fromJson(Map<String, dynamic> json) {
    userID = json["userId"];
    userName = json["userName"];
    password = json["password"];
    phoneNumber = json["phoneNumber"];
    publishedDate = json["publishedDate"];
    status = json["status"];
  }
}
