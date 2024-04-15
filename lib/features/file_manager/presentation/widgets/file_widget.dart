import 'dart:io';

import 'package:file_manager_application/features/file_manager/data/file_manager_repo.dart';
import 'package:file_manager_application/features/file_manager/presentation/widgets/show_dialog_create_update.dart';
import 'package:file_manager_application/utilities/get_directoreis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as p;

import '../../../../utilities/enum.dart';
import 'show_modal_bottom_sheet.dart';
class FileWidget extends ConsumerWidget {
  const FileWidget({super.key,required this.e});
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
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onLongPress: showOption,
        onTap: (){
        OpenFile.open(e.path);  
        },
        child: Row(
          children: [
            Icon(FontAwesomeIcons.file,color: Colors.blueAccent,),
            SizedBox(width: 4,),
            Text(e.path.split("/").last,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
             const Spacer(),
              IconButton(onPressed: showOption, icon:const Icon(FontAwesomeIcons.ellipsisVertical))
          ],
        ),
      ),
    );
  }
}