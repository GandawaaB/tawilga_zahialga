// ignore_for_file: must_be_immutable

import 'package:augmented_reality_plugin/augmented_reality_plugin.dart';
import 'package:flutter/material.dart';
// import 'package:augmented_reality_plugin/augmented_reality_plugin.dart';
import 'package:flutter/services.dart';
// import 'package:vector_math/vector_math.dart' ;
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
// import 'arcore_flutter_plugin.dart';

import 'package:vector_math/vector_math_64.dart' as vector;
import 'dart:io';

class VirtualARViewScreen extends StatefulWidget {
  String? clickedItemImageLink;

  VirtualARViewScreen(this.clickedItemImageLink);

  @override
  State<VirtualARViewScreen> createState() => _VirtualARViewScreenState();
}

class _VirtualARViewScreenState extends State<VirtualARViewScreen> {
  late ArCoreController arCoreController;

  void whenArCoreViwCreated(ArCoreController controller) async {
    // File imageFile = File('assets/profile_login.png');

    // List<int> imageBytes = await imageFile.readAsBytes();
    // print(imageBytes);



    arCoreController = controller;
    arCoreController.onNodeTap = (name) => handleNodeTap(name);
    arCoreController.onPlaneTap = controlOnPlaneTap; 
    // final byts = (await rootBundle.load("assets/profile_login.png"))
    //     .buffer
    //     .asUint8List();
    //     print("bytes:$byts");
    // arCoreController.loadSingleAugmentedImage(bytes: byts);

    // arCoreController = controller;
    // arCoreController.onPlaneTap = controlOnPlaneTap;
  }

  void handleNodeTap(String name) {
    
    if (name == 'firstArIMG') {
      // Display the image
      // Add your logic to show the image using Flutter widgets
    }
  }

  void controlOnPlaneTap(List<ArCoreHitTestResult> result) {
    final hit = result.first;
    print("hit + $hit");
    addItemImageScene(hit);
  }

  Future addItemImageScene(ArCoreHitTestResult hitTestResult) async {
    // final bytes = Uint8List.fromList( widget.clickedItemImageLink as List<int>);
    final bytes =
        (await rootBundle.load(widget.clickedItemImageLink.toString()))
            .buffer
            .asUint8List();
    print("Bytes:$bytes");

    
      final imageItem = ArCoreNode(
        image: ArCoreImage(bytes: bytes, width: 600, height: 600),
        position:
            hitTestResult.pose.translation + vector.Vector3(0.0, 0.0, 0.0),
        rotation:
            hitTestResult.pose.rotation + vector.Vector4(0.0, 0.0, 0.0, 0.0),
      );
      arCoreController.addArCoreNodeWithAnchor(imageItem);
      // ArCoreApk_checkAv
  
  }

  @override
  Widget build(BuildContext context) {
    return AugmentedRealityPlugin(widget.clickedItemImageLink.toString());
    // return Scaffold(
    //   body: ArCoreView(
    //     onArCoreViewCreated: whenArCoreViwCreated,
    //     enableTapRecognizer: true,
    //     enableUpdateListener: true,
    //   ),
    // );
  }
}
