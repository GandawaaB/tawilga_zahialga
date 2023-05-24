import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationScreeen extends StatefulWidget {
  const NotificationScreeen({super.key});

  @override
  State<NotificationScreeen> createState() => _NotificationScreeenState();
}

class _NotificationScreeenState extends State<NotificationScreeen> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat.yMMMEd().format(now);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 100,
          child: Card(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.notifications),
                SizedBox( width: 20,),
                
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Text(
                      "Message ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("Хэрэглэгчийн бүртгэл амжилттай үүслээ"),
                    Text(formattedDate),
                  ],
                ),
                const Divider(
                  height: 20,
                  thickness: 5,
                  indent: 20,
                  endIndent: 0,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
