import 'dart:io';

import 'package:file_manager_application/features/file_manager/file_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
String rootDir="";
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(Platform.isAndroid){
    final storagePermStts= await Permission.storage.request();
      final managePermStts =   await Permission.manageExternalStorage.request();
      if(storagePermStts.isGranted&&managePermStts.isGranted){
  Directory? directory = await getExternalStorageDirectory();
  // 0 is where the data are stored and we can accessed (it is for all the android devices)
  rootDir=  directory?.path.substring(0,directory.path.indexOf("0")+1)??"";
  }
  }
  runApp(const
    ProviderScope(child:  MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'File Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FileManagerScreen(path: rootDir,),
    );
  }
}
