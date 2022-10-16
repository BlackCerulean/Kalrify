import 'package:flutter/material.dart';

final kHintTextStyle = TextStyle(
  color: Colors.grey.shade400,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Color.fromRGBO(255, 120, 90,1),
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Colors.grey.shade300,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);
