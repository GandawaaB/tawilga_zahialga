import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/arcore_flutter_plugin.dart';
// import 'package:furniture_app/src/arcore_android_view.dart';
import './widgets/utils.dart';
import './start_screen.dart';

Future< void> main() async {
  try{
    WidgetsFlutterBinding.ensureInitialized();
    print("Arcore is available?");
    print(await ArCoreController.checkArCoreAvailability());

    print("\nAr server instelled?");
    print(await ArCoreController.checkIsArCoreInstalled());

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
    messengerKey;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
          
      ),
      
      home:StartScreen(),
      
      
    );
  }
}
