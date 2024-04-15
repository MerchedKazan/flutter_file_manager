import 'dart:io';
import 'package:file_manager_application/features/file_manager/data/file_manager_repo.dart';
import 'package:file_manager_application/features/file_manager/presentation/widgets/file_widget.dart';
import 'package:file_manager_application/features/file_manager/presentation/widgets/folder_widget.dart';
import 'package:file_manager_application/features/file_manager/presentation/widgets/show_dialog_create_update.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';



class FileManagerScreen extends StatefulWidget {
  const FileManagerScreen({super.key,required this.path});
  final String path;

  @override
  State<FileManagerScreen> createState() => _FileManagerScreenState();
}

class _FileManagerScreenState extends State<FileManagerScreen> {
  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      appBar: AppBar(title: Text(widget.path.split("/").last=="0"?"Internal Storage":widget.path.split("/").last),centerTitle: false,actions: [
        Consumer(
          builder: (context,ref,_) {
            return IconButton(onPressed: ()async{
                            String? newFolderName=await  showDialogCreateRename(context, true);
                            if(newFolderName!=null&&newFolderName.isNotEmpty){
                   ref.read(fileManagerRepoProv).createDirectory(widget.path, newFolderName);
                            }
            }, icon:const Icon(FontAwesomeIcons.folderPlus,color: Colors.amberAccent,));
          }
        )
      ],),
      body: Consumer(builder: (context,ref,_){
        final currentFiles=ref.watch(getDirectoriesControllerProv(widget.path));
        return currentFiles.when(data: (data){
          data.reversed.toList();
       return data.isEmpty?
      const Center(child: Text("The folder is empty"),):
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            TextButton(onPressed: (){
                ref.read(getDirectoriesControllerProv(widget.path).notifier).reversed();
            }, child: Text("Sorting A-Z",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)),
          Expanded(
            child: ListView(
              children: data.map((e) {
                if(e is File){
                  return FileWidget(e: e);
                }else{
                  return FolderWidget(e: e);
                }
              }).toList(),
            ),
          ),
        ],
      );
        }, error: (e,st)=>Center(child: Text("Please try again"),), loading: ()=>Center(child: CircularProgressIndicator.adaptive(),));
      })
      ,
    );
  }
}