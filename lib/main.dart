import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'permission_page.dart';


late final bool isReadAllow;
//late final bool isManageAllow;

Future<void> main() async {
  await GetStorage.init();
  isReadAllow = await Permission.storage.status.isGranted;
  //isManageAllow = await Permission.manageExternalStorage.status.isGranted;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.amber,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: isReadAllow
          ? const HomePage()
          : PermissionPage(
              isReadAllow: isReadAllow,
              //isManageAllow: isManageAllow,
            ),
    );
  }
}
