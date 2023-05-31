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
     final ThemeData themeData = ThemeData(
      primaryColor: HexColor.fromHex("#414F81"), 
      accentColor: Color.fromARGB(255, 0, 255, 0), // Green color
      // Other theme properties...
    );
    return MaterialApp(
      
      title: 'Flutter Demo',
      theme: themeData,
      
      home:StartScreen(),
      
      
    );
    
  }
  
}
extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
