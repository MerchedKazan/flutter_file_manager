import 'dart:io';

import 'package:file_manager_application/features/file_manager/data/file_manager_repo.dart';
import 'package:file_manager_application/features/file_manager/file_manager.dart';
import 'package:file_manager_application/features/file_manager/presentation/widgets/show_dialog_create_update.dart';
import 'package:file_manager_application/features/file_manager/presentation/widgets/show_modal_bottom_sheet.dart';
import 'package:file_manager_application/utilities/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FolderWidget extends ConsumerWidget {
  const FolderWidget({super.key, required this.e}); 
  final FileSystemEntity e;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    showOption()async{
  SelectOption? option=await showModalBottomSheetOptions(context,e);
           if(option!=null){
            if(option==SelectOption.renmae){
              String? renameText=await  showDialogCreateRename(context, false, path: e.path);
             if(renameText!=null&&renameText.isNotEmpty){
              ref.read(fileManagerRepoProv).renameDirectory(e, renameText);
             }
            }else{
            ref.read(fileManagerRepoProv).deleteDirectory(e);
            }  
           }
}
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        padding:const EdgeInsets.symmetric(vertical: 8),
        decoration:const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black12))
        ),
        child: InkWell(
          onLongPress: showOption,
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (_)=>FileManagerScreen(path: e.path)));
          },
          child: Row(
            children: [
              const Icon(FontAwesomeIcons.solidFolder,color: Colors.amberAccent,),
              const SizedBox(width: 6,),
              Text(e.path.split("/").last,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,),),
              const Spacer(),
              IconButton(onPressed: showOption, icon:const Icon(FontAwesomeIcons.ellipsisVertical))
            ],
          ),
        ),
      ),
    );
  }
}