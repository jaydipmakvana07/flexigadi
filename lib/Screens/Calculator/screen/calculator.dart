import 'package:flutter/material.dart';

import '../screen/mapscreen.dart';
import '../../Driver/components/bottommenu.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _HomedriverScreenState createState() => _HomedriverScreenState();
}

class _HomedriverScreenState extends State<Calculator> {
  bool isKeyboardVisible = false;

  void _onFocusChange(bool hasFocus) {
    setState(() {
      isKeyboardVisible = hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Add this line to prevent screen resizing

      body: Column(
        children: [
          Expanded(
            child: MapView(),
          ),
          Visibility(
            visible: !isKeyboardVisible,
            child: BottomMenuBar(
              initialIndex: 3,
              onTabChanged: (index) {
                // Handle the tab change if needed
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const Calculator());
}
