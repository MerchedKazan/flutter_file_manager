import 'package:flutter/material.dart';
import "package:path/path.dart" as p;
showDialogCreateRename(BuildContext context,bool isCreate,{String path=""})async{
  final _key=GlobalKey<FormState>();
  return await  showDialog(context: context, builder: (context){
              TextEditingController controller=TextEditingController(text: p.basenameWithoutExtension(path));
              return Form(
                key: _key,
                child: AlertDialog(
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(isCreate?"Create Folder":"Rename",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (val){
                        if(val==null || val.isEmpty){
                          return "Name can't be empty";
                        }
                        return null;
                      },
                      controller: controller,
                    )
                  ],
                ),
                actionsAlignment: MainAxisAlignment.spaceBetween,
                actions: [
                  TextButton(onPressed: (){
                    Navigator.of(context).pop("");
                  }, child: Text("Cancel")),
                  TextButton(onPressed: (){
                    if(_key.currentState!.validate()){
                    Navigator.of(context).pop(controller.text);
                    }
                  }, child: Text("Ok"))
                ],
                            ),
              );
             });
}