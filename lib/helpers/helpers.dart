import 'package:flutter/material.dart';

// Widget widgetByName(String widgetName) {
// widgetName = capitalize(widgetName);
// return ${widgetName}();
// }

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

Widget handleErrorWidget(Map data) {
  return Center(
    child: Text(
      'Error: ${data["message"]}',
    ),
  );
}
