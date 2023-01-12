import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:loginsin/resources/assets_manager.dart';
import 'package:loginsin/resources/color_manager.dart';
import 'package:loginsin/ui/screens/home/card_list.dart';

class TotalItems extends StatefulWidget {
  const TotalItems({Key? key}) : super(key: key);

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
          title: const Text('Home', style: TextStyle(color: Colors.black)),
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
                      Container(
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
                child: FirebaseAnimatedList(
                  query: ref,
                  defaultChild: Text("Loading"),
                  itemBuilder: (context, snapshot, animation, index) {
                    return CardList(snapshot: snapshot);
                  },
                ),
              ),

            ],
          ),
          Positioned(
            bottom: 10,
            left: 50,
            right: 50,
            child: Container(
              height: 40,
              width: 280,
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
            left: 150,
            child: Container(
              height: 38.5,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.shopping_cart),
                    const SizedBox(width: 5,),
                    const Text("totals",style: TextStyle(color: Colors.grey,fontSize: 10,fontWeight: FontWeight.w600),),
                    const SizedBox(width: 2,),
                    Text("100",style: TextStyle(color: ColorManager.primaryUi,fontSize: 12,fontWeight: FontWeight.bold,),),
                    


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
