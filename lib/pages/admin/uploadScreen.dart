import 'dart:ffi';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart' as fStorage;

import '../navbar/navbar.dart';
import 'api_customer.dart';

class UploadScreen extends StatefulWidget {
  Uint8List? imageFileUnit8List;
  UploadScreen({required this.imageFileUnit8List});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  List<String> list = [];
  String dropdownValue = "test";
  bool isUploading = false;
    TextEditingController sellerNameEditController = TextEditingController();
    TextEditingController itemNameEditController = TextEditingController();
    TextEditingController sellerPhoneEditController = TextEditingController();
    TextEditingController itemDescriptionEditController =
        TextEditingController();
    TextEditingController itemPriceEditController = TextEditingController();
      String downloadUrlOfUploadedImage = '';
      
  TextEditingController _categoryController = TextEditingController();
  
  get imageFileUnit8List => imageFileUnit8List;
    
      // Uint8List  imageFileUnit8List = imageFileUnit8List ;     

   @override
  void initState() {
    super.initState();
    // Call your function here
    getDataFromFirestore();
  }

  Future<void> getDataFromFirestore() async {
     final   QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('category').get();


    List<String> data = snapshot.docs
        .map((doc) => doc.get('categoryName') as String)
        .toList();
        setState(() {
      list = data; 
      print(list);
    });


    
  }
  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        // backgroundColor: Colors.black,
        title: const Text(
          'Upload New Item',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (isUploading != true) {
                validateUploadFormAndItemInfo(imageFileUnit8List,downloadUrlOfUploadedImage );
              }
            },
            icon: Icon(Icons.cloud_upload),
            color: Colors.white,
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users-favorite-items')
              .orderBy("publishedDate", descending: true)
              .snapshots(),
          builder: (context, AsyncSnapshot dataSnapshot) {
            if (dataSnapshot.hasData) {
              return ListView(
                // return Text("");
                children: [
                  isUploading == true
                      ? const LinearProgressIndicator(
                          color: Colors.purpleAccent,
                        )
                      : Container(),
                  SizedBox(
                    height: 230,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: widget.imageFileUnit8List != null
                        ? Image.memory(widget.imageFileUnit8List!)
                        : const Center(
                            child: Icon(
                              Icons.image_not_supported,
                              color: Colors.black,
                            ),
                          ),
                  ),
                  const Divider(
                    color: Colors.black12,
                    thickness: 2,
                  ),

                  //seller name
                  ListTile(
                    leading: const Icon(
                      Icons.person_pin_rounded,
                      color: Colors.black54,
                    ),
                    title: SizedBox(
                      width: 250,
                      child: TextField(
                        style: TextStyle(color: Colors.grey),
                        controller: sellerNameEditController,
                        decoration: const InputDecoration(
                          hintText: "Админ нэр",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.black12,
                    thickness: 1,
                  ),
                  //seller phone
                  ListTile(
                    leading: const Icon(
                      Icons.phone_iphone_rounded,
                      color: Colors.black54,
                    ),
                    title: SizedBox(
                      width: 250,
                      child: TextField(
                        style: TextStyle(color: Colors.grey),
                        controller: sellerPhoneEditController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: "Админ утасны дугаар",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.black12,
                    thickness: 1,
                  ),
                  //item name
                  ListTile(
                    leading: const Icon(
                      Icons.title,
                      color: Colors.black54,
                    ),
                    title: SizedBox(
                      width: 250,
                      child: TextField(
                        style: TextStyle(color: Colors.grey),
                        controller: itemNameEditController,
                        decoration: const InputDecoration(
                          hintText: "Бүтээгдэхүүний нэр",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.black12,
                    thickness: 1,
                  ),
                  //item description
                  ListTile(
                    leading: const Icon(
                      Icons.description,
                      color: Colors.black54,
                    ),
                    title: SizedBox(
                      width: 250,
                      child: TextField(
                        style: TextStyle(color: Colors.grey),
                        controller: itemDescriptionEditController,
                        decoration: const InputDecoration(
                          hintText: "Бүтээгдэхүүний тайлбар",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.black12,
                    thickness: 1,
                  ),
                  //item price
                  ListTile(
                    leading: const Icon(
                      Icons.price_change,
                      color: Colors.black54,
                    ),
                    title: SizedBox(
                      width: 250,
                      child: TextField(
                        style: TextStyle(color: Colors.grey),
                        controller: itemPriceEditController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: "Бүтээгдэхүүний үнэ",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.black12,
                    thickness: 1,
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 15),
                      const Icon(
                        Icons.category,
                        color: Colors.black54,
                      ),
                      const SizedBox(width: 30),
                      DropdownButton<String>(
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_drop_down),
                        elevation: 16,
                        style: const TextStyle(color: Colors.black54),
                        underline: Container(
                          height: 2,
                          color: Colors.black54,
                        ),
                        onChanged: (String? newvalue) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropdownValue = newvalue!;
                          });
                        },
                        items:
                            list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      IconButton(
                          onPressed: () {
                            addCategoryBox(context);
                          },
                          icon: Icon(
                            Icons.add_circle_outline,
                            color: Colors.black54,
                            size: 20,
                          ))
                    ],
                  ),
                ],
              );
            }
            return Text("data");
          }),
          
    );
   
    
  }
  
  validateUploadFormAndItemInfo(imageFileUnit8List,downloadUrlOfUploadedImage) async {
    if (imageFileUnit8List != null) {
      if (sellerNameEditController.text.isNotEmpty &&
          itemNameEditController.text.isNotEmpty &&
          sellerPhoneEditController.text.isNotEmpty &&
          itemDescriptionEditController.text.isNotEmpty &&
          itemPriceEditController.text.isNotEmpty) {
        setState(() {});

        //1. image upload to cload storage

        String imageUniqueName =
            DateTime.now().millisecondsSinceEpoch.toString();
        fStorage.Reference firebaseStorageRef = fStorage
            .FirebaseStorage.instance
            .ref()
            .child("ItemsImages")
            .child(imageUniqueName);
        fStorage.UploadTask uploadTaskImageFile =
            firebaseStorageRef.putData(imageFileUnit8List!);
        fStorage.TaskSnapshot taskSnapshot =
            await uploadTaskImageFile.whenComplete(() => null);

        await taskSnapshot.ref.getDownloadURL().then((imageDownloadUrl) {
          downloadUrlOfUploadedImage = imageDownloadUrl;
        });

        //2. save item info to firestore database
        saveItemInfoToFirestore(imageFileUnit8List);
      } else {
        Fluttertoast.showToast(msg: "Та бүх талбарыг бөглөнө үү!");
      }
    } else {
      Fluttertoast.showToast(msg: "Та зурагаа оруулна уу!");
    }
  }
  saveItemInfoToFirestore(imageFileUnit8List) {
    String imageUniqueId = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseFirestore.instance.collection("items").doc(imageUniqueId).set({
      "itemId": imageUniqueId,
      "itemName": itemNameEditController.text,
      "itemDescription": itemDescriptionEditController.text,
      "itemImage": downloadUrlOfUploadedImage,
      "sellerName": sellerNameEditController.text,
      "sellerPhone": sellerPhoneEditController.text,
      "itemPrice": itemPriceEditController.text,
      "publishedDate": DateTime.now(),
      "category": dropdownValue,
      "status": "available",
    });

    Fluttertoast.showToast(msg: "Амжилттай нэмэгдлээ.");
    setState(() {
      isUploading = false;
      imageFileUnit8List = null;
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (c) => NavigationScreen()));
  }
  Future<void> addCategoryBox(BuildContext context) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(title: const Text('Ангилал нэмэх'), children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _categoryController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ангилал',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.green)),
                  onPressed: () {
                    addCategoryAction();
                    Navigator.of(context).pop();
                  },
                  child: Text("нэмэх")),
            ),
          ]

              // actions: <Widget>[
              //   TextButton(
              //     style: TextButton.styleFrom(
              //       textStyle: Theme.of(context).textTheme.labelLarge,
              //     ),
              //     child: const Text('Disable'),
              //     onPressed: () {
              //       Navigator.of(context).pop();
              //     },
              //   ),
              //   TextButton(
              //     style: TextButton.styleFrom(
              //       textStyle: Theme.of(context).textTheme.labelLarge,
              //     ),
              //     child: const Text('Enable'),
              //     onPressed: () {
              //       Navigator.of(context).pop();
              //     },
              //   ),
              // ],
              );
        });
  }
  
  addCategoryAction() async {
    String uniqueId = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseFirestore.instance.collection("category").doc(uniqueId).set({
      "categoryId": uniqueId,
      "categoryName": _categoryController.text,
      "publishedDate": DateTime.now(),
    });
    Fluttertoast.showToast(msg: "Амжилттай нэмэгдлээ.");
    setState(() {
      _categoryController.text = "";
    });
  }
  
}