import 'package:flutter/material.dart';
import 'package:expopharma/pages/sospharma/InventaireLigne.dart';


void showTotal(BuildContext context, int totalNew, int totalOld) {
  showModalBottomSheet(
    backgroundColor: Colors.grey[50],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    context: context,
    builder: (context) => Container(
      height: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Total NEW : " + totalNew.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue)),
          Text("Total stock: " + totalOld.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red)),
        ],),
    ),
  );
}