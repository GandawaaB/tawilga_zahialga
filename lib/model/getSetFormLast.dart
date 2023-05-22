import 'package:flutter/material.dart';

import '../pages/communication.dart';
import '../pages/serviceSettings.dart';
// import './settingsForms/serviceSettings.dart';
// import './settingsForms/communication.dart';

class getSetForm2 extends StatelessWidget {
  IconData icon1;
  IconData icon2;
  String name;

  getSetForm2({
    required this.icon1,
    required this.icon2,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Icon(icon1),
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              icon: Icon(icon2),
              onPressed: () {
                if (name == "Холбоо барих") {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CommunicationSettings();
                  }));
                } else if (name == 'Үйлчилгээний нөхцөл') {
                   Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ServiceSettigs();
                  }));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
