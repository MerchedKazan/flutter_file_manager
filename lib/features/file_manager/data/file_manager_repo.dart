import 'dart:io';

import 'package:file_manager_application/utilities/get_directoreis.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
class FileManagerRepo{
  final Ref ref;
  FileManagerRepo(this.ref);
  Future<List<FileSystemEntity>> getDirectoriesData(String path)async{
    return await getDirectories(path);
  }
  createDirectory(String path,String nameOfFolder)async{
       Directory("${path}/$nameOfFolder").create();
      //  Directory(nameOfFolder).create();
        ref.refresh(getDirectoriesControllerProv(path));
  }
  bool directoryExist(String path,String nameOfFolder){
   return  Directory("$path/$nameOfFolder").existsSync();
  }

  deleteDirectory(FileSystemEntity e)async{
        // final file=  File("path");
        // await file.statSync().;
        e.deleteSync(recursive:true);
        ref.refresh(getDirectoriesControllerProv(e.parent.path));
  }
  renameDirectory(FileSystemEntity e,String nameOfDirectory)async{
    String newPath = e.parent.path + '/' + nameOfDirectory + p.extension(e.path);
          e.renameSync(newPath);
          
        ref.refresh(getDirectoriesControllerProv(e.parent.path));
  }
}


final fileManagerRepoProv=Provider.autoDispose((ref) => FileManagerRepo(ref));


class GetDirectoriesController extends StateNotifier<AsyncValue<List<FileSystemEntity>>>{
  GetDirectoriesController(this.path):super(AsyncData([]));
  final String path;
  void init()async{
    state=const AsyncLoading();
    state = await AsyncValue.guard(() => getDirectories(path));
  }
    getDirectoriesData(String path)async{
    state=const AsyncLoading();
    state = await AsyncValue.guard(() => getDirectories(path));
  }
  reversed(){
    state=AsyncData(state.value!.reversed.toList());
  }
}

final getDirectoriesControllerProv=StateNotifierProvider.autoDispose.family<GetDirectoriesController,AsyncValue<List<FileSystemEntity>>,String>((ref,path) => GetDirectoriesController(path)..init());