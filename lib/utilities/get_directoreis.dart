import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as p;

Future<List<FileSystemEntity>> getDirectories(String path)async{
    try{
         PermissionStatus storagePermission= await Permission.storage.request();
         if(storagePermission.isGranted){
         Directory root = Directory(path); // Access the root directory
        List<FileSystemEntity> _currentFiles = [];
        List<FileSystemEntity> _files = [];
      List<FileSystemEntity> _folder = [];
      for (var v in root.listSync(followLinks: false)) {
        if (p.basename(v.path).substring(0, 1) == '.') {
          continue;
        }
        if (FileSystemEntity.isFileSync(v.path)) {
          _files.add(v);
        } else {
          _folder.add(v);
        }
      }
       _files.sort((a, b) => a.path.toLowerCase().compareTo(b.path.toLowerCase()));
      _folder.sort((a, b) => a.path.toLowerCase().compareTo(b.path.toLowerCase()));
      _currentFiles.clear();
      _currentFiles.addAll(_folder);
      _currentFiles.addAll(_files);
      return _currentFiles;
    }else{
       return [];
    }
    } catch(e){
      print("error $e");
       return [];
     
    }
  }