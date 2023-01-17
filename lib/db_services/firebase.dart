import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loginsin/user_preferences/user_preferences.dart';

class dbFirebase {

  static createCart(qty,wid,total,pid) async {
    FirebaseFirestore firestore =
        FirebaseFirestore.instance;

    var query = await firestore
        .collection('cart')
        .where('pid',
        isEqualTo:
        pid)
        .where('wid', isEqualTo: wid)
        .get();
    if (query.size == 0) {
      await firestore.collection('cart').add({
        'uid': await UserPreferences.getUserId(),
        'quantity': qty,
        'wid': wid,
        'pid': pid,
        'total': total,
      });
    }
    else{
      var docid = query.docs.first.id;
      firestore.collection('cart').doc(docid).update({
        'quantity': qty,
        'total': total,
      });
    }
  }

  static createWishlistTotalAndQuantity (wid,total) async {
    FirebaseFirestore firestore =
        FirebaseFirestore.instance;
    var dbqty = await firestore
        .collection("Wishlist")
        .doc(wid)
        .get()
        .then(
            (value) => value.get("quantity"));
    var dbTotal = await firestore
        .collection("Wishlist")
        .doc(wid)
        .get()
        .then((value) => value.get("total"));
    await firestore
        .collection("Wishlist")
        .doc(wid)
        .update({
      "quantity": dbqty += 1,
      "total": dbTotal += total
    });
  }


}