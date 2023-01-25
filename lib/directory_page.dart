import 'dart:io';
import 'package:file_manager/file_manager.dart';

import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'preferences.dart';
import 'tile_grid.dart';
import 'tile_list.dart';

class DirectoryPage extends StatefulWidget {
  const DirectoryPage({Key? key, required this.entity}) : super(key: key);
  final FileSystemEntity entity;

  @override
  State<DirectoryPage> createState() => _DirectoryPageState();
}

class _DirectoryPageState extends State<DirectoryPage> {
  final FileManagerController fileManagerController = FileManagerController();
  late bool showGrid;

  @override
  void initState() {
    showGrid = Preferences.getViewType();
    fileManagerController.openDirectory(widget.entity);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //elevation: 0,
        //backgroundColor: Colors.transparent,
        title: ValueListenableBuilder<String>(
            valueListenable: fileManagerController.titleNotifier,
            builder: (context, text, child) {
              return Text(text == '0' ? 'Device' : text);
            }),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                showGrid = !showGrid;
                Preferences.setViewType(showGrid);
              });
            },
            icon: Icon(showGrid ? Icons.grid_on_rounded : Icons.list_alt),
          ),
        ],
      ),
      body: ControlBackButton(
        controller: fileManagerController,
        child: FileManager(
          controller: fileManagerController,
          builder: (context, listFileSystemEntity) {
            return showGrid
                ? GridView.builder(
                    itemCount: listFileSystemEntity.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      crossAxisCount: 4,
                    ),
                    itemBuilder: (context, index) {
                      return TileGrid(
                        entity: listFileSystemEntity[index],
                        onTap: () {
                          FileManager.isFile(listFileSystemEntity[index])
                              ? null
                              : fileManagerController
                                  .openDirectory(listFileSystemEntity[index]);
                        },
                      );
                    },
                  )
                : ListView.builder(
                    itemCount: listFileSystemEntity.length,
                    itemBuilder: (context, index) => TileList(
                      entity: listFileSystemEntity[index],
                      onTap: () {
                        FileManager.isFile(listFileSystemEntity[index])
                            ? OpenFilex.open(listFileSystemEntity[index].path)
                            : fileManagerController
                                .openDirectory(listFileSystemEntity[index]);
                      },
                    ),
                  );
          },
        ),
      ),
    );
  }
}
