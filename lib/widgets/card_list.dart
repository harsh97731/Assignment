import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:loginsin/db_services/firebase.dart';
import 'package:loginsin/resources/assets_manager.dart';
import 'package:loginsin/resources/color_manager.dart';
import 'package:loginsin/user_preferences/user_preferences.dart';

class CardList extends StatefulWidget {
  // String imageName;
  // String productName;
  // String description;
  // String prize;
  DataSnapshot snapshot;
  String wid;
  CardList(
      {Key? key,
      // required this.imageName,
      // required this.productName,
      // required this.description,
      // required this.prize,
      required this.snapshot,
      required this.wid})
      : super(key: key);

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('product');
  int qty = 0;
  int total = 0;

  getQuantity() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var quary = await firestore
        .collection("cart")
        .where("pid", isEqualTo: widget.snapshot.child("pid").value)
        .where("wid", isEqualTo: widget.wid)
        .get();
    if (quary.size == 0) {
    } else {
      var cId = quary.docs.first.id;
      var x = await firestore
          .collection("cart")
          .doc(cId)
          .get()
          .then((value) => value.get("quantity"));
      setState(() {
        qty = x;
      });
    }
  }
  void initState() {
    getQuantity();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 150,
        width: 100,
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  height: 150,
                  width: 130,
                  child: ClipRRect(
                      child: Image.network(
                    widget.snapshot.child('image').value.toString(),
                    fit: BoxFit.cover,
                  )),
                ),
                Container(
                  height: 18,
                  width: 100,
                  decoration: BoxDecoration(
                    color: ColorManager.discountColor,
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(25)),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 5, top: 3),
                    child: Text(
                      "10% Discount",
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
                //10 per discount
                Positioned(
                  bottom: 3,
                  right: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        children: [
                          Icon(Icons.star,
                              color: ColorManager.primaryUi, size: 12),
                          SizedBox(
                            width: 2,
                          ),
                          Text("4.5",
                              style: TextStyle(
                                  color: ColorManager.primaryUi, fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ), // image
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: 60,
                      height: 25,
                      child: Image.asset(ImageAssets.tesco)),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(widget.snapshot.child('desc').value.toString()),
                  const SizedBox(
                    height: 8,
                  ),
                  Text("(500 g - £5)",
                      style: TextStyle(color: Colors.grey, fontSize: 13)),
                  SizedBox(
                    height: 5,
                  ),
                  Text(widget.snapshot.child('desc').value.toString(),
                      style: TextStyle(
                        color: ColorManager.description,
                      )),
                ],
              ),
            ), //middle
            Padding(
              padding: const EdgeInsets.only(top: 35, left: 5),
              child: Column(
                children: [
                  Text("6 x KG"),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(widget.snapshot.child('prize').value.toString(),
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: ColorManager.primaryUi)),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: ColorManager.dashContainer,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    height: 25,
                    width: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                          },
                          child: Icon(
                            Icons.remove_circle_outline_rounded,
                            color: ColorManager.primaryUi,
                          ),
                        ),
                        Text("$qty"),
                        InkWell(
                          onTap: () async {
                            setState(() {
                              qty += 1;
                              total = (widget.snapshot.child('prize').value
                                      as int) *
                                  qty;
                            });

                            dbFirebase.createCart(qty, widget.wid, total, widget.snapshot.child('pid').value);
                            dbFirebase.createWishlistTotalAndQuantity(widget.wid, total);
                          },
                          child: Icon(
                            Icons.add_circle_outline_outlined,
                            color: ColorManager.primaryUi,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //prize values
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
