import 'package:pdf/widgets.dart' as pw;
// import 'package:pdf/pdf.dart' as pdf;
//les packages flutter marchent pas sans ui
// import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';

import 'dart:convert';

class Json_container {
  Map<String, dynamic> _container;
  Json_container(this._container);

  pw.Alignment _getAlignment() {
    String? alignment = _container['alignment'];
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
      case 'center':
        return pw.Alignment.center;
    }
    return pw.Alignment.center;
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
  print(jsonContainer._getAlignment());
}
