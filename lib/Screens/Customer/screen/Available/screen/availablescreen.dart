import 'package:flutter/material.dart';

import '../componenets/available.dart';
import '../../../components/uppermenu.dart';
import '../../../components/bottommenu.dart';

class AvailableScreen extends StatefulWidget {
  const AvailableScreen({Key? key}) : super(key: key);

  @override
  _HomedriverScreenState createState() => _HomedriverScreenState();
}

class _HomedriverScreenState extends State<AvailableScreen> {
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child:
            UpperMenu(title: 'Available Car'), // Use UpperMenu as the app bar
      ),
      body: Column(
        children: [
          Expanded(
            child: Available(),
          ),
          Visibility(
            visible: !isKeyboardVisible,
            child: BottomMenuBar(
              initialIndex: 0,
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
  runApp(const AvailableScreen());
}
