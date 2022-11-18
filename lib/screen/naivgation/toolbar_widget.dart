
import 'package:flutter/material.dart';

class ToolbarWidget {

  static addToolbar(BuildContext context, String? title){
   return Container(
     padding: EdgeInsets.all(10),
     width: double.infinity,
     child: Row(
       children: [
         IconButton(
           color: Colors.grey,
           icon: Icon(Icons.arrow_back_ios_new_rounded),
           onPressed: () { Navigator.pop(context); },
         ),
         Text(title ?? 'SIAPrint', style: TextStyle(color: Colors.grey),)
       ],
     ),
   );
  }

}