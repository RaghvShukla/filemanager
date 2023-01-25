import 'homepage.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionPage extends StatefulWidget {
  const PermissionPage({
    Key? key,
    required this.isReadAllow,
    //required this.isManageAllow,
  }) : super(key: key);
  final bool isReadAllow;
  // final bool isManageAllow;

  @override
  State<PermissionPage> createState() => _PermissionPageState();
}

class _PermissionPageState extends State<PermissionPage> {
  late bool isReadAllow;
  //late bool isManageAllow;

  @override
  void initState() {
    isReadAllow = widget.isReadAllow;
    //isManageAllow = widget.isManageAllow;
    super.initState();
  }

  Future<void> switchReadPermission() async {
    if (isReadAllow) {
      setState(() {
        isReadAllow = !isReadAllow;
      });
    } else {
      await Permission.storage.request();
      bool readPermission = await Permission.storage.status.isGranted;
      setState(() {
        isReadAllow = readPermission;
      });
    }
  }

  // Future<void> switchManagePermission() async {
  //   if (isManageAllow) {
  //     setState(() {
  //       isManageAllow = !isManageAllow;
  //     });
  //   } else {
  //     await Permission.storage.request();
  //     bool managePermission = await Permission.manageExternalStorage.status.isGranted;
  //     setState(() {
  //       isManageAllow = managePermission;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 50),
            const Text(
              "Permission required",
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(height: 50),
            ListTile(
              title: const Text("Allow Read Permission"),
              subtitle:
                  const Text("Read permission must required to show files"),
              leading: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.amber[600],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.folder,
                  size: 25,
                  color: Colors.white,
                ),
              ),
              trailing: Switch(
                value: isReadAllow,
                onChanged: (value) {
                  switchReadPermission();
                },
              ),
            ),
            // const SizedBox(height: 20),
            // ListTile(
            //   title: const Text("Allow Manage Permission"),
            //   subtitle: const Text(
            //       "Manage permission must required to manage files and folders"),
            //   leading: Container(
            //     padding: const EdgeInsets.all(6),
            //     decoration: BoxDecoration(
            //       color: Colors.amber[600],
            //       borderRadius: BorderRadius.circular(12),
            //     ),
            //     child: const Icon(
            //       Icons.sd_card,
            //       size: 25,
            //       color: Colors.white,
            //     ),
            //   ),
            //   trailing: Switch(
            //     value: isManageAllow,
            //     onChanged: (value) {
            //       switchManagePermission();
            //     },
            //   ),
            // ),
            const SizedBox(height: 80),
            SizedBox(
              height: 55,
              width: 250,
              child: ElevatedButton(
                onPressed: isReadAllow
                    ? () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                            (route) => false);
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber[700]),
                child: Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
