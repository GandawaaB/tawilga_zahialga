import 'package:flutter/material.dart';
import 'package:furniture_app/homeScreen.dart';
import 'package:furniture_app/login_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 44, 90, 128),
      body: SizedBox(
        width: width,
        height: height,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            const Positioned(
              child: Text(
                'Тавилга захиалга',
                style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    // color: FvColors.container94Background,
                    wordSpacing: 1.0),
              ),
            ),
            Positioned(
              bottom: 50,
              child: ButtonBar(
                alignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    //to login screen
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (c) => const Loginscreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'ЭХЛЭХ',
                      style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          // color: FvColors.container94Background,
                          wordSpacing: 1.0),
                    ),
                  ),
                ],
              ),
            ), //end start button
            const Positioned(
              bottom: 30,
              child: Text(
                "2023",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    wordSpacing: 1.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
