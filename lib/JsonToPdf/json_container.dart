import 'package:pdf/widgets.dart' as pw;
// import 'package:pdf/pdf.dart' as pdf;
//les packages flutter marchent pas sans ui
// import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';

import 'dart:convert';



// TODO: implementer les autres propriétés
// TODO: creer une methode qui verifie si la propriete existe dans le json
// TODO: implementer un systeme de retour d'erreur si la propriete n'existe pas
class Json_container {
  Map<String, dynamic> _container;
  Json_container(this._container);

  List<dynamic> _convertIntListToDouble(List<dynamic> liste){
    List<dynamic> ret = [];
    for (var i = 0; i < liste.length; i++) {
      if(liste[i] is int){
        ret.add(liste[i].toDouble());
      }else{
        ret.add(liste[i]);
      }
    }
    return ret;
  }
  pw.Alignment _getAlignment() {
    Object alignment = _container['alignment'];
    if (alignment is String) {
      switch (alignment) {
        case 'center':
          return pw.Alignment.center;
        case 'topCenter':
          return pw.Alignment.topCenter;
        case 'topLeft':
          return pw.Alignment.topLeft;
        case 'topRight':
          return pw.Alignment.topRight;
        case 'centerLeft':
          return pw.Alignment.centerLeft;
        case 'centerRight':
          return pw.Alignment.centerRight;
        case 'bottomCenter':
          return pw.Alignment.bottomCenter;
        case 'bottomLeft':
          return pw.Alignment.bottomLeft;
        case 'bottomRight':
          return pw.Alignment.bottomRight;
        default:
          return pw.Alignment.center;
      }
    } else if (alignment is List<dynamic> && alignment.length == 2) {
      alignment = _convertIntListToDouble(alignment);
      return pw.Alignment(alignment[0], alignment[1]);
    } else {
      return pw.Alignment.center;
    }
  }

  pw.EdgeInsets _getPadding(){
    final padding = _container['padding'];
    return _getEdge(padding);
  }

  pw.EdgeInsets _getMargin(){
    final margin = _container['margin'];
    return _getEdge(margin);
  }

  pw.EdgeInsets _getEdge(final Edge) {
    if (Edge is int || Edge is double) {
      return pw.EdgeInsets.all(Edge.toDouble());
    } 
    else if (Edge is List<dynamic> && Edge.length == 2){
      List<dynamic> liste = _convertIntListToDouble(Edge);
      return pw.EdgeInsets.symmetric(
          vertical: liste[0], horizontal: liste[1]);
    }
    else if (Edge is List<dynamic> && Edge.length == 4) {
      List<dynamic> liste = _convertIntListToDouble(Edge);
      return pw.EdgeInsets.fromLTRB(
          liste[0], liste[1], liste[2], liste[3]);
    } else {
      return pw.EdgeInsets.all(0);
    }
  }

  double? _getwidth() {
    final width = _container['width'];
    if (width is int || width is double) {
      return width.toDouble();
    } else {
      return null;
    }
  }
  double? getheight() {
    final height = _container['height'];
    if (height is int || height is double) {
      return height.toDouble();
    } else {
      return null;
    }
  }

}
Future<Map<String, dynamic>> loadJson() async {
  final file = File('./test.json');
  final jsonString = await file.readAsString();
  return json.decode(jsonString);
}

void main() async {
  final jsonData = await loadJson();
  final jsonContainer = Json_container(jsonData);
  // print(jsonContainer._getAlignment());
  print(jsonContainer._getPadding());
  print(jsonContainer._getMargin());
  print(jsonContainer._getwidth());
  print(jsonContainer.getheight());
}
