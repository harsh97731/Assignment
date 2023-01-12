import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:loginsin/resources/assets_manager.dart';
import 'package:loginsin/resources/color_manager.dart';

class CardList extends StatefulWidget {
  // String imageName;
  // String productName;
  // String description;
  // String prize;
  DataSnapshot snapshot;

  CardList(
      {Key? key,
      // required this.imageName,
      // required this.productName,
      // required this.description,
      // required this.prize,
      required this.snapshot})
      : super(key: key);

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('product');
  CollectionReference ref1 = FirebaseFirestore.instance.collection('product');
   var counter = 0;
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
                      child: Image.network(widget.snapshot.child('image').value.toString()
                    ,
                    fit: BoxFit.cover,
                  )),
                ),
                Container(
                  height: 18,
                  width: 100,
                  decoration: BoxDecoration(
                    color: ColorManager.discountColor,
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(25)),
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
                  SizedBox(
                    height: 3,
                  ),
              Text(widget.snapshot.child('desc').value.toString()),
                  SizedBox(
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
                          onTap: (){
                            counter++;

                          },
                          child: Icon(Icons.remove_circle_outline_rounded,
                            color: ColorManager.primaryUi,),
                        ),
                        Text(widget.snapshot.child('0').value.toString()),
                        Icon(
                          Icons.add_circle_outline_outlined,
                          color: ColorManager.primaryUi,
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
