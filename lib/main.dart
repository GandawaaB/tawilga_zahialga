import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './homeScreen.dart';

Future< void> main() async {
  try{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
     
  }
  catch(errorMsg){
    print('Error:'+ errorMsg.toString());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
