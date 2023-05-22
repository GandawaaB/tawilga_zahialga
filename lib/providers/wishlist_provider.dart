import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../model/wishlist.dart';

class WishListProvider with ChangeNotifier {
  Map<String, WishListModel> _wishListItem = {};
  Map<String, WishListModel> get getWishListItems {
    return _wishListItem;
  }

  final userCollection = FirebaseFirestore.instance.collection("users");
  Future<void> fetchWishList() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final DocumentSnapshot userDoc = await userCollection.doc(user!.uid).get();
    // ignore: unnecessary_null_comparison
    if (userDoc == null) {
      return;
    }
    final leng = userDoc.get('userWish').length;
    for (int i = 0; leng < i; i++) {
      _wishListItem.putIfAbsent(
        userDoc.get('userWish')[i]('productId'),
        () => WishListModel(
          userDoc.get('userWish')[i]('wishListId'),
          userDoc.get('userWish')[i]('productId'),
        ),
      );
    }
    notifyListeners();
  }

  Future<void> removeOneItem(
      {required String wishListId, required String productId}) async {
    final User? user = FirebaseAuth.instance.currentUser;
    await userCollection.doc(user!.uid).update({
      'userWish': FieldValue.arrayRemove([
        {
          'wishListId': wishListId,
          'productId': productId,
        }
      ])
    });
  }

  Future<void> clearOnlineWishList() async {
    final User? user = FirebaseAuth.instance.currentUser;
    await userCollection.doc(user!.uid).update({'userWish': []});
    _wishListItem.clear();
    notifyListeners();
  }

  void clearLocalWishList() {
    _wishListItem.clear();
    notifyListeners();
  }
}
