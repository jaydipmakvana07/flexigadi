import 'package:flexigadi/Screens/Agent/screen/Profile/screen/profile.dart';
import 'package:flutter/material.dart';

import '../../../components/bottommenu.dart';

class ProfileAgentScreen extends StatefulWidget {
  const ProfileAgentScreen({Key? key}) : super(key: key);

  @override
  _HomedriverScreenState createState() => _HomedriverScreenState();
}

class _HomedriverScreenState extends State<ProfileAgentScreen> {
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
            child: ProfileAgent(),
          ),
          Visibility(
            visible: !isKeyboardVisible,
            child: BottomMenuBar(
              initialIndex: 4,
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
  runApp(const ProfileAgentScreen());
}
