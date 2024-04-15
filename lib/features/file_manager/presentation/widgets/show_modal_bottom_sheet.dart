
import 'dart:io';

import 'package:file_manager_application/features/file_manager/presentation/widgets/details_row_widget.dart';
import 'package:file_manager_application/utilities/enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

showModalBottomSheetOptions(BuildContext context,FileSystemEntity e){
 return showModalBottomSheet(context: context, builder: (contex ){
    return Container(
      decoration:const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        )
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DetailsRowWidget(title: "Last Modified", details: DateFormat('yyyy-MM-dd HH:mm:ss').format(e.statSync().modified)),
            DetailsRowWidget(title: "Last Accesed", details: DateFormat('yyyy-MM-dd HH:mm:ss').format(e.statSync().accessed)),
            DetailsRowWidget(title: "Last Changed", details: DateFormat('yyyy-MM-dd HH:mm:ss').format(e.statSync().changed)),
            DetailsRowWidget(title: "Size", details: "${e.statSync().size} Kb"),
            const Divider(),
            CupertinoButton(child: Text("Rename",style: TextStyle(color: Colors.lightGreen),), onPressed: (){
              Navigator.of(contex).pop(SelectOption.renmae);
            }),
            const Divider(),
            CupertinoButton(child: Text("Delete",style: TextStyle(color: Colors.redAccent),), onPressed: (){
            Navigator.of(contex).pop(SelectOption.delete);

            }),
          ],
        ),
      ),
    );
  });
}