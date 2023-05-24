import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furniture_app/api_customer.dart';
import 'package:furniture_app/homeScreen.dart';
import 'package:furniture_app/pages/navbar/navbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;


class ItemsUploadScreen extends StatefulWidget {
  const ItemsUploadScreen({super.key});
  
  @override
  State<ItemsUploadScreen> createState() => _ItemsUploadScreenState();
}

class _ItemsUploadScreenState extends State<ItemsUploadScreen> {
  Uint8List? imageFileUnit8List;
  bool isUploading = false;
  TextEditingController sellerNameEditController = TextEditingController();
  TextEditingController itemNameEditController = TextEditingController();
  TextEditingController sellerPhoneEditController = TextEditingController();
  TextEditingController itemDescriptionEditController = TextEditingController();
  TextEditingController itemPriceEditController = TextEditingController();
  String downloadUrlOfUploadedImage = '';

  // ignore: non_constant_identifier_names
  Widget UploadFromScreen() {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
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
                validateUploadFormAndItemInfo();
              }
            },
            icon: Icon(Icons.cloud_upload),
            color: Colors.white,
          )
        ],
      ),
      body: ListView(
        children: [
          isUploading == true
              ? const LinearProgressIndicator(
                  color: Colors.purpleAccent,
                )
              : Container(),
          SizedBox(
            height: 230,
            width: MediaQuery.of(context).size.width * 0.8,
            child: imageFileUnit8List != null
                ? Image.memory(imageFileUnit8List!)
                : const Center(
                    child: Icon(
                      Icons.image_not_supported,
                      color: Colors.grey,
                    ),
                  ),
          ),
          const Divider(
            color: Colors.white70,
            thickness: 2,
          ),

          //seller name
          ListTile(
            leading: const Icon(
              Icons.person_pin_rounded,
              color: Colors.white,
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                style: TextStyle(color: Colors.grey),
                controller: sellerNameEditController,
                decoration: const InputDecoration(
                  hintText: "seller name",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.white70,
            thickness: 1,
          ),
          //seller phone
          ListTile(
            leading: const Icon(
              Icons.phone_iphone_rounded,
              color: Colors.white,
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                style: TextStyle(color: Colors.grey),
                controller: sellerPhoneEditController,
                decoration: const InputDecoration(
                  hintText: "seller phone",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.white70,
            thickness: 1,
          ),
          //item name
          ListTile(
            leading: const Icon(
              Icons.title,
              color: Colors.white,
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                style: TextStyle(color: Colors.grey),
                controller: itemNameEditController,
                decoration: const InputDecoration(
                  hintText: "item name",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.white70,
            thickness: 1,
          ),
          //item description
          ListTile(
            leading: const Icon(
              Icons.description,
              color: Colors.white,
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                style: TextStyle(color: Colors.grey),
                controller: itemDescriptionEditController,
                decoration: const InputDecoration(
                  hintText: "item description",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.white70,
            thickness: 1,
          ),
          //item price
          ListTile(
            leading: const Icon(
              Icons.price_change,
              color: Colors.white,
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                style: TextStyle(color: Colors.grey),
                controller: itemPriceEditController,
                decoration: const InputDecoration(
                  hintText: "item price",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.white70,
            thickness: 1,
          ),
        ],
      ),
    );
  }

  validateUploadFormAndItemInfo() async {
    if (imageFileUnit8List != null) {
      if (sellerNameEditController.text.isNotEmpty &&
          itemNameEditController.text.isNotEmpty &&
          sellerPhoneEditController.text.isNotEmpty &&
          itemDescriptionEditController.text.isNotEmpty &&
          itemPriceEditController.text.isNotEmpty) {
        setState(() {

        });

        //1. image upload to cload storage
        
        String  imageUniqueName =
            DateTime.now().millisecondsSinceEpoch.toString();
        fStorage.Reference firebaseStorageRef = fStorage
            .FirebaseStorage.instance
            .ref()
            .child("ItemsImages")
            .child(imageUniqueName);
        fStorage.UploadTask uploadTaskImageFile = firebaseStorageRef.putData(imageFileUnit8List!);
        fStorage.TaskSnapshot taskSnapshot = await uploadTaskImageFile.whenComplete(() => null);

        await taskSnapshot.ref.getDownloadURL().then((imageDownloadUrl) {
          downloadUrlOfUploadedImage = imageDownloadUrl;
        });


        //2. save item info to firestore database
        saveItemInfoToFirestore();
      } else {
        Fluttertoast.showToast(msg: "Та бүх талбарыг бөглөнө үү!");
      }
    } else {
      Fluttertoast.showToast(msg: "Та зурагаа оруулна уу!");
    }
  }

  saveItemInfoToFirestore() {
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
      "status": "available",
    });
    

    Fluttertoast.showToast(msg: "Амжилттай нэмэгдлээ.");
    setState(() {
      isUploading = false;
      imageFileUnit8List = null;
    });
    Navigator.push(context, MaterialPageRoute(builder: (c) => NavigationScreen()));
  }

  Widget defaultScreen() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: const Text(
          "Upload New Item",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.add_photo_alternate,
              color: Colors.black26,
              size: 200,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  showDailogBox();
                },
                child: const Text(
                  "Add New Item",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ))
          ],
        ),
      ),
    );
  }

  showDailogBox() {
    return showDialog(
      context: context,
      builder: (c) {
        return SimpleDialog(
          backgroundColor: Colors.white,
          title: const Text(
            "Item Image",
            style:
                TextStyle(color: Colors.black , fontWeight: FontWeight.bold),
          ),
          children: [
            //camera
            SimpleDialogOption(
              onPressed: () {
                captureImageWithCamera();
              },
              child: const Text(
                "Capture image with Camera",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            // gallery
            SimpleDialogOption(
              onPressed: () {
                chooseImageFromGallery();
              },
              child: const Text(
                "Choose image from Gallerry",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            //cancel
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            )
          ],
        );
      },
    );
  }

  captureImageWithCamera() async {
    Navigator.pop(context);
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);

      if (pickedImage != null) {
        String imagePath = pickedImage.path;
        imageFileUnit8List = await pickedImage.readAsBytes();
        imageFileUnit8List =
            await ApiCustomer().removeImageBackgroundApi(imagePath);

        setState(() {
          imageFileUnit8List;
        });
      }
    } catch (error) {
      print("error:" + error.toString());
      setState(() {
        imageFileUnit8List = null;
      });
    }
  }

  chooseImageFromGallery() async {
    Navigator.pop(context);
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        String imagePath = pickedImage.path;
        imageFileUnit8List = await pickedImage.readAsBytes();
        imageFileUnit8List =
            await ApiCustomer().removeImageBackgroundApi(imagePath);

        setState(() {
          imageFileUnit8List;
        });
      }
    } catch (error) {
      print("error:" + error.toString());
      setState(() {
        imageFileUnit8List = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return imageFileUnit8List == null ? defaultScreen() : UploadFromScreen();
  }
}
