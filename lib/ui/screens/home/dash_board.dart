import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:loginsin/resources/color_manager.dart';
import 'package:loginsin/resources/string_manager.dart';
import 'package:loginsin/ui/screens/home/product_list.dart';

import '../authentication/changedpassword/ChangedPassword.dart';
import '../authentication/login/LoginPage.dart';

class DashBord extends StatefulWidget {
  const DashBord({Key? key}) : super(key: key);

  @override
  State<DashBord> createState() => _DashBordState();
}

class _DashBordState extends State<DashBord> {
  //var firestoreDB = FirebaseFirestore.instance.collection('Wishlist').snapshots();
  int index = 0;
  int counter = 0;

  final String? _username = FirebaseAuth.instance.currentUser?.displayName;
  final String? user_email = FirebaseAuth.instance.currentUser?.email;
  final String? user_id = FirebaseAuth.instance.currentUser?.uid;

  final CarouselController carouselController = CarouselController();
  final _listName = TextEditingController();
  int currentIndex = 0;

  addData() {
    Map<String, dynamic> data = {
      'name': _listName.text,
      'quantity': 0,
      'total': 0,
      'uid': user_id,
    };


    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('Wishlist');
    collectionReference.add(data);
  }

  List<Widget> screens = [
    const Center(child: Text("My home page")),
    const Center(child: Text("My home pa")),
    const Center(child: Text("My home page")),
    const Center(child: Text("My home page")),
    const Center(child: Text("My home page"))
  ];
  List imageList = [
    {"id": 1, "image_path": 'assets/images/food1.jpeg'},
    {"id": 2, "image_path": 'assets/images/food2.jpeg'},
    {"id": 3, "image_path": 'assets/images/food3.jpeg'},
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                  title: const Text('Alert'),
                  content: const Text('Do you want to exit app?'),
                  actions: [
                    ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ColorManager.primaryUi,
                            foregroundColor: Colors.white),
                        child: const Text('NO')),
                    ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white),
                        child: const Text('Exit')),
                  ]);
            });
        if (value != null) {
          return Future.value(value);
        } else {
          return Future.value(false);
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                InkWell(
                  onTap: () {
                    if (kDebugMode) {
                      if (kDebugMode) {
                        print(currentIndex);
                      }
                    }
                  },
                  child: CarouselSlider(
                    items: imageList
                        .map(
                          (item) => Image.asset(
                            item["image_path"],
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        )
                        .toList(),
                    carouselController: carouselController,
                    options: CarouselOptions(
                        scrollPhysics: const BouncingScrollPhysics(),
                        aspectRatio: 2,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        }),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imageList.asMap().entries.map((entry) {
                      if (kDebugMode) {
                        print(entry);
                      }
                      if (kDebugMode) {
                        print(entry.key);
                      }
                      return GestureDetector(
                        onTap: () =>
                            carouselController.animateToPage(entry.key),
                        child: Container(
                          width: currentIndex == entry.key ? 17 : 7,
                          height: 7.0,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 3.0,
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                              color: currentIndex == entry.key
                                  ? ColorManager.primaryUi
                                  : Colors.lightGreenAccent),
                        ),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: _listName,
                //validator: ,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                            width: 2, color: ColorManager.primaryUi)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                            width: 2, color: ColorManager.primaryUi)),
                    hintText: "Add list name",

                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          decoration: BoxDecoration(
                            color: ColorManager.primaryUi,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: InkWell(
                            onTap: () {
                              counter++;
                              addData();
                            },
                            child: Icon(
                              Icons.add,
                              color: ColorManager.white,
                            ),
                          )),
                    )),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    StringManager.addShoppingList,
                    style: TextStyle(
                        color: ColorManager.primaryUi,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Wishlist")
                      .where("uid",
                      isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    //print("fsta : ${snapshot.data?.docs}");
                    return ListView.builder(
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, int index) {
                          QueryDocumentSnapshot<Object?> documentsnapshot = snapshot.data!.docs.elementAt(index);
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 1, vertical: 1),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TotalItems(wid: documentsnapshot.id,
                                        title: "${snapshot.data?.docs[index]['name']}",
                                      ),
                                    ));
                              },
                              child: Card(
                                child: SizedBox(
                                  height: 100,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 20,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot.data?.docs[index]['name']
                                                      .toString() ??
                                                  '',
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 10,
                                              ),
                                              child: Container(
                                                width: 100,
                                                height: 100,
                                                color:
                                                    ColorManager.dashContainer,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          const Text(
                                                              StringManager
                                                                  .total,
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400)),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          //FirebaseFirestore.instance.collection('list').doc('id')
                                                          Text(snapshot
                                                                  .data
                                                                  ?.docs[index][
                                                                      'quantity']
                                                                  .toString() ??
                                                              ''),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 3,
                                                      ),
                                                      Text(snapshot
                                                              .data
                                                              ?.docs[index]
                                                                  ['total']
                                                              .toString() ??
                                                          ''),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ), //totals cost
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  }),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.black,
                ), //BoxDecoration
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.black),
                  accountName: Text(
                    "${_username}",
                    style: TextStyle(fontSize: 18),
                  ),
                  accountEmail: Text('$user_email'),
                  currentAccountPictureSize: Size.square(50),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 255, 251, 251),

                    child: Text(
                      "H",
                      style: TextStyle(fontSize: 30.0, color: Colors.black),
                    ), //Text
                  ), //circleAvatar
                ), //UserAccountDrawerHeader
              ), //DrawerHeader
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text(' My Profile '),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.book),
                title: const Text(' Payment method'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.workspace_premium),
                title: const Text(' Address '),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.password_sharp),
                title: const Text(' Change Password '),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChangedPassword(),
                      ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text(' Household'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),

              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('LogOut'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          title: const Text('Alert'),
                          content: const Text('Do you want to exit app?'),
                          actions: [
                            ElevatedButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorManager.primaryUi,
                                    foregroundColor: Colors.white),
                                child: const Text('NO')),
                            ElevatedButton(
                                onPressed: () => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    )),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    foregroundColor: Colors.white),
                                child: const Text('Exit')),
                          ]);
                    },
                  );
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: ColorManager.primaryUi,
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.location_on_outlined)),
              ],
            )
          ],
        ),
        bottomNavigationBar: GNav(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          onTabChange: (val) {
            index;

            setState(() {
              index = val;
            });
          },
          gap: 2,
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
              textColor: Colors.green,
              iconColor: Colors.green,
            ),
            GButton(
              icon: Icons.people,
              text: 'Vendors',
              textColor: Colors.green,
              iconColor: Colors.green,
            ),
            GButton(
              icon: Icons.list,
              text: 'List',
              textColor: Colors.green,
              iconColor: Colors.green,
            ),
            GButton(
              icon: Icons.category,
              text: 'Category',
              textColor: Colors.green,
              iconColor: Colors.green,
            ),
            GButton(
              icon: Icons.menu_open,
              text: 'Menu',
              textColor: Colors.green,
              iconColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
