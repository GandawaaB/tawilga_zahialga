import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/widgets/basketWidget.dart';
// import 'package:furniture_app/pages/navbar/user.dart';

// import '../../model/items.dart';
import '../../model/itemsBasket.dart';
// import '../../widgets/basketWidget.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({super.key});

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users-basket-items')
            .doc(user!.email)
            .collection('items')
            .orderBy("publishedDate", descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot dataSnapshot) {
          if (dataSnapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                 Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Сагсан дахь бараанууд:",
                    style: TextStyle(fontSize: 20, color: Colors.black38),
                  ),
                ),
                // Center(child: Text("Сагс")),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 0.3),
                      
                        borderRadius:const BorderRadius.all(
                          Radius.circular(20),
                        )),
                    // color: Color.fromARGB(255, 223, 223, 223),
                    height: 400,
                    child: Column(
                      children: [
                        SizedBox(height: 12,),
                        Container(
                          height: 376,
                          child: ListView.builder(
                            itemCount: dataSnapshot.data!.docs.length,
                            itemBuilder: (context, i) {
                              ItemsBasket eachIteminfo = ItemsBasket.fromJson(
                                  dataSnapshot.data!.docs[i].data()
                                      as Map<String, dynamic>);
                        
                              // print(eachIteminfo.itemImage.toString());
                              // return Text("Name:${eachIteminfo.total}");
                              return BasketWidget(
                                context: context,
                                basketItem: eachIteminfo,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Нийт: ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      "\$322",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color.fromARGB(255, 245, 63, 50)),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 0, top: 10),
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    child: Text(
                      "ТӨЛӨХ",
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {},
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 1.0, color: Colors.grey),
                  ),
                ),
              ],
            );
          } else {
            Text("empty");
          }
          return Text("null");
        },
      ),
    );

    // Column(
    //   children: [

    // ],
    // ),
    // );
  }
}
