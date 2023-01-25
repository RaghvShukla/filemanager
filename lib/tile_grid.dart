import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_manager/file_manager.dart';
import 'file_icon.dart';

class TileGrid extends StatelessWidget {
  const TileGrid({
    Key? key,
    required this.entity,
    required this.onTap,
  }) : super(key: key);
  final FileSystemEntity entity;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bool isFile = FileManager.isFile(entity);
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xfff5f5f5),
        foregroundColor: Colors.grey,
        padding: const EdgeInsets.all(2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          FileIcon(
            isFile: isFile,
            extension: isFile ? FileManager.getFileExtension(entity) : '',
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
            child: Text(
              FileManager.basename(entity),
              maxLines: 1,
              style: const TextStyle(fontSize: 12, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
