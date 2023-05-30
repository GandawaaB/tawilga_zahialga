import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/Item_ui_design_widget.dart';
import 'package:furniture_app/login_screen.dart';
// import './Items_upload_screen.dart';
import 'model/items.dart';
// import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  String? name = "";

  @override
  Widget build(BuildContext context) {
    _onChange(String val) {}
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('items')
            .orderBy("publishedDate", descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot dataSnapshot) {
          if (dataSnapshot.hasData) {
            return SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                height: 700,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          // fillColor: Colors.white,
                          labelText: 'Search...',
                          prefixIcon: const Icon(Icons.search),
                        ),
                        onChanged: (val) {
                          setState(() {
                            name = val;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height - 290,
                              width: double.infinity,
                              child: GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5,
                                  childAspectRatio: 0.8,
                                ),
                                itemCount: dataSnapshot.data.docs.length,
                                itemBuilder: (context, index) {
                                  Items eachIteminfo = Items.fromJson(
                                      dataSnapshot.data!.docs[index].data()
                                          as Map<String, dynamic>);
                                  if (name!.isEmpty) {
                                    return ItemUIDesignWidget(
                                        eachIteminfo, context);
                                  } else if (eachIteminfo.itemName
                                      .toString()
                                      .startsWith(name
                                          .toString()
                                          .toLowerCase()
                                          .trim())) {
                                     return ItemUIDesignWidget(eachIteminfo, context);
                                    // return (Text(
                                    //     eachIteminfo.itemName.toString()));
                                  }
                                  // return Text("Хайлт олдсонгүй...");
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                // Padding(
                //   padding:
                //       const EdgeInsets.symmetric(vertical: 0, horizontal: 9),
                //   child: Row(
                //     children: [
                //       Text(user.email!),
                //       TextButton(
                //         onPressed: () => logOut(),
                //         child: const Text(
                //           "гарах",
                //           style: TextStyle(color: Colors.red),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                Center(
                  child: Text(
                    "Өгөгдөл байхгүй байна.",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 30,
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
