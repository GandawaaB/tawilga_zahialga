// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:augmented_reality_plugin/augmented_reality_plugin.dart';
import 'package:flutter/services.dart';
// import 'package:vector_math/vector_math.dart' ;

import 'arcore_flutter_plugin.dart';

import 'package:vector_math/vector_math_64.dart' as vector;

class VirtualARViewScreen extends StatefulWidget {
  String? clickedItemImageLink;

  VirtualARViewScreen(this.clickedItemImageLink);

  @override
  State<VirtualARViewScreen> createState() => _VirtualARViewScreenState();
}

class _VirtualARViewScreenState extends State<VirtualARViewScreen> {
  late ArCoreController arCoreController;

  void whenArCoreViwCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController.onPlaneTap = controlOnPlaneTap;
  }

  void controlOnPlaneTap(List<ArCoreHitTestResult> result) {
    final hit = result.first;
    addItemImageScene(hit);
  }

  Future addItemImageScene(ArCoreHitTestResult hitTestResult) async {
    final bytes = Uint8List.fromList( widget.clickedItemImageLink as List<int>);
    // final bytes =
    //     (await rootBundle.load()).buffer.asUint8List();
    // print("Bytes:$bytes");
    try {
      final imageItem = ArCoreNode(
        image: ArCoreImage(bytes: bytes, width: 600, height: 600),
        position:
            hitTestResult.pose.translation + vector.Vector3(0.0, 0.0, 0.0),
        rotation:
            hitTestResult.pose.rotation + vector.Vector4(0.0, 0.0, 0.0, 0.0),
      );
      arCoreController.addArCoreNodeWithAnchor(imageItem);
      // ArCoreApk_checkAv 
    } catch (err) {
      print("err:$err");
    }
  }

  @override
  Widget build(BuildContext context) {
    return AugmentedRealityPlugin(widget.clickedItemImageLink.toString());
    // return ArCoreView(
    //   onArCoreViewCreated: whenArCoreViwCreated,
    //   enableTapRecognizer: true,
    // );
  }
}
