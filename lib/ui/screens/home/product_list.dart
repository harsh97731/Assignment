import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:loginsin/resources/assets_manager.dart';
import 'package:loginsin/resources/color_manager.dart';
import 'package:loginsin/widgets/card_list.dart';

class TotalItems extends StatefulWidget {
  final String title ;
  String wid;
 TotalItems({Key? key, required this.title,required this.wid}) : super(key: key);

  @override
  State<TotalItems> createState() => _TotalItemsState();
}

class _TotalItemsState extends State<TotalItems> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('product');
  // CollectionReference ref = FirebaseFirestore.instance.collection('product');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          title: Text(widget.title,style: const TextStyle(color: Colors.black),),
          backgroundColor: Colors.white,
          actions: const [
            Icon(
              Icons.search,
              color: Colors.black,
            ),
            SizedBox(
              width: 8,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.qr_code_scanner,
                color: Colors.black,
              ),
            ),
          ]),
      body: Stack(
        children: [
          Column(
            //main column
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width :60,
                          height: 25,
                          child: Image.asset(ImageAssets.tesco)),
                      const SizedBox(
                        width: 250,
                      ),
                      Icon(Icons.person_add, color: ColorManager.primaryUi),
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.share, color: ColorManager.primaryUi),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Container(
                    height: 45,
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: ColorManager.primaryUi, width: 1.5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 60),
                      child: Row(
                        children: [
                          Icon(
                            Icons.store,
                            color: ColorManager.primaryUi,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text("Go to Store",
                              style: TextStyle(
                                color: ColorManager.primaryUi,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),             //add person
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 65),
                  child: FirebaseAnimatedList(
                    query: ref,
                    defaultChild: const Text("Loading"),
                    itemBuilder: (context, snapshot, animation, index) {
                      return CardList(wid: widget.wid,snapshot: snapshot);
                    },
                  ),
                ),
              ),

            ],
          ),
          Positioned(
            bottom: 10,
            left: 45,
            right: 45,

            child: Container(
              height: 50,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: ColorManager.primaryUi,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 35,right: 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                        Icon(Icons.list_alt,color: Colors.white,),
                    Text("Buy the list",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white,

                    ),)


                        ]),

                ),
              ),

          ),
          Positioned(
            bottom: 11,
            left: 130,
            child: Container(
              height: 50,
              width: 110,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Icon(Icons.shopping_cart),
                    const SizedBox(width: 13,),
                    Column(
                      children: [
                        const Text("Totals",style: TextStyle(color: Colors.black,fontSize: 8,),),
                        const SizedBox(height: 4,),
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("Wishlist")
                              .doc(widget.wid)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var data = snapshot.data?.get("total");
                              return Text(data.toString(),
                                  style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold));
                            } else {
                              return const Text("0",
                                  style: TextStyle(
                                    fontSize: 10,
                                  ));
                            }
                          },
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
      
    );
  }
}
