import 'package:flexigadi/Screens/Customer/screen/Requirement/components/requirement_list.dart';

import 'package:flutter/material.dart';

import '../../../components/uppermenu.dart';
import '../../../components/bottommenu.dart';

class RequirementAgentScreen extends StatefulWidget {
  const RequirementAgentScreen({Key? key}) : super(key: key);

  @override
  _HomedriverScreenState createState() => _HomedriverScreenState();
}

class _HomedriverScreenState extends State<RequirementAgentScreen> {
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
        child: UpperMenu(title: 'Requirements'), // Use UpperMenu as the app bar
      ),
      body: Column(
        children: [
          Expanded(
            child: Requirements(),
          ),
          Visibility(
            visible: !isKeyboardVisible,
            child: BottomMenuBar(
              initialIndex: 1,
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
  runApp(const RequirementAgentScreen());
}
