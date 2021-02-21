// import 'package:flutter/material.dart';
// class ArtList extends StatelessWidget {
//   final nom;
//   final forme;
//   final indication;
//   final proprietes;
//   final utilisation;
//   final contenance;
//   final prix;
//
//   ArtList(
//       {this.nom, this.forme, this.prix, this.indication, this.proprietes, this.contenance, this.utilisation,});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: InkWell(
//       child: Container(
//         height: 200,
//         width: 100,
//         child: Card(
//           child: Row(
//             children: <Widget>[
//               Expanded(
//                 flex: 1,
//                 child: Image.asset('images/labo/avene/avecmi.jfif'),
//               ),
//               Expanded(
//                   flex: 2,
//                   child: Container(
//                       height: 200,
//                       padding: EdgeInsets.all(10),
//                       alignment: Alignment.topLeft,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Row(
//                             children: [
//                               Text(
//                                 'Designation: ',
//                                 style: TextStyle(
//                                   fontSize: 10,
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Text(
//                                   nom != null ? nom : '',
//                                   textAlign: TextAlign.start,
//                                   style: TextStyle(
//                                     color: Colors.blueGrey,
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//
//                           Row(
//                             children: [
//                               Text(
//                                 'Forme: ',
//                                 style: TextStyle(
//                                   fontSize: 10,
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                               Text(
//                                 forme !=null ? forme : '',
//                                 textAlign: TextAlign.start,
//                                 style: TextStyle(
//                                   color: Colors.blueGrey,
//                                   fontSize: 10,
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 'Indication: ',
//
//                                 style: TextStyle(
//                                   fontSize: 10,
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                               Text(
//                                 indication != null ? indication : '',
//                                 style: TextStyle(
//                                   color: Colors.grey,
//                                   fontSize: 10,
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                             ],
//                           ),
//
//                           Row(
//                             crossAxisAlignment:
//                             CrossAxisAlignment.start,
//                             children: [
//
//                               Text(
//                                 'Proprités: ',
//                                 style: TextStyle(
//                                   fontSize: 10,
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//
//                               Column(
//                                 crossAxisAlignment:
//                                 CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   Text(
//                                     proprietes != null ? proprietes : '',
//                                     style: TextStyle(
//                                       color: Colors.grey,
//                                       fontSize: 10,
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                   ),
//                                   Text(
//                                     'Sans parfum',
//                                     style: TextStyle(
//                                       color: Colors.grey,
//                                       fontSize: 10,
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                   ),
//
//                                 ],
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children:<Widget> [
//                               Text(
//                                 'Contenance: ',
//                                 style: TextStyle(
//                                   fontSize: 10,
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                               Text(
//                                 contenance != null ? contenance : '',
//                                 style: TextStyle(
//                                   color: Colors.grey,
//                                   fontSize: 10,
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                             ],
//                           ),
//
//
//                           Row(
//                             children: [Text(
//                               'Prix :',
//                               style: TextStyle(
//                                 color: Colors.green,
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w700,
//                               ),
//                             ),
//                               Container(
//                                 margin: EdgeInsets.only(top: 2),
//                                 decoration: BoxDecoration(
//                                     border: Border.all(color: Colors.red)),
//                                 padding: EdgeInsets.all(3),
//                                 child: Text(
//                                   prix != null ? prix : '',
//                                   style: TextStyle(
//                                     color: Colors.green,
//                                     fontSize: 13,
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 5,),
//                           Text(
//                             'Pour plus d\'information taper sur l\'image',
//                             style: TextStyle(
//                                 color: Colors.orange, fontSize: 10),
//                           )
//                         ],
//                       )))
//               //Expended التمدد
//             ],
//           ),
//         ),
//       ),
//       onTap: () {
//         Navigator.of(context).pushNamed('detailart');
//       },
//     ));
//   }
// }
