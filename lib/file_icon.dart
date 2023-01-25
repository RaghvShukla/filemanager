import 'package:flutter/material.dart';
import 'extension.dart';

class FileIcon extends StatelessWidget {
  const FileIcon({
    Key? key,
    this.extension,
    required this.isFile,
  }) : super(key: key);
  final String? extension;
  final bool isFile;

  @override
  Widget build(BuildContext context) {
    return isFile
        ? Image.asset(
            extensions[extension] ?? 'assets/unknown.png',
            height: 35,
          )
        : Container(
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
          );
  }
}
