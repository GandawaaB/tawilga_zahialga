import 'package:flutter/material.dart';
// import './settingsForms/userUpdate.dart';

class getSettingsForm extends StatelessWidget {
  IconData icon1;
  IconData icon2;
  String name;
  String phone;

  getSettingsForm({
    required this.icon1,
    required this.icon2,
    required this.name,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(children: [
        Expanded(
          flex: 1,
          child: Icon(icon1),
        ),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  name,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Text(phone),
            ],
          ),
        ),
        Expanded(
            flex: 1,
            child: IconButton(
              icon: Icon(icon2),
              onPressed: () {
                
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return userUpdate();
                  // }));
                
              },
            )),
      ]),
    );
  }
}
