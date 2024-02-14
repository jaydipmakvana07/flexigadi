import 'package:flutter/material.dart';

import '../components/home_image.dart';
import '../../../components/appbar.dart';
import '../../../components/bottommenu.dart';

class HomecustomerScreen extends StatefulWidget {
  const HomecustomerScreen({Key? key}) : super(key: key);

  @override
  _HomedriverScreenState createState() => _HomedriverScreenState();
}

class _HomedriverScreenState extends State<HomecustomerScreen> {
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
        child: UpperMenu(title: 'Home'), // Use UpperMenu as the app bar
      ),
      body: Column(
        children: [
          Expanded(
            child: HomeImage(),
          ),
          Visibility(
            visible: !isKeyboardVisible,
            child: BottomMenuBar(
              initialIndex: 2,
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
  runApp(const HomecustomerScreen());
}
