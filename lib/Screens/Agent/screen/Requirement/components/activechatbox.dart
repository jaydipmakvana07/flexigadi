import 'package:flexigadi/Screens/Agent/screen/Requirement/components/confirmbutton.dart';

import 'package:flutter/material.dart';
import '../../../../../constants.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(GroupChatApp());
}

class GroupChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GroupChatScreen();
  }
}

class GroupChatScreen extends StatefulWidget {
  @override
  _GroupChatScreenState createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  TextEditingController _textController = TextEditingController();
  List<Map<String, String>> _messages = [
    {"name": "You", "message": "2300??"},
    {"name": "Driver 4", "message": "2400"},
    {"name": "You", "message": "2100?"},
    {"name": "Driver 2", "message": "2600"},
    {"name": "You", "message": "Anyone with 2000??"},
    {"name": "Driver 4", "message": "2700"},
    {"name": "Driver 3", "message": "2750"},
    {"name": "Driver 2", "message": "2800"},
    {"name": "Driver 1", "message": "3000"},

    // Add more messages here as needed
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Active Requirement'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              reverse: true,
              itemBuilder: (BuildContext context, int index) {
                final message = _messages[index];
                return GestureDetector(
                  onTap: () {
                    // Handle the tap action for the name here
                    // For example, you can open a profile page or perform any other action
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => ConfirmdriverScreen(),
                    ));
                  },
                  child: MessageBubble(
                    name: message['name']!,
                    message: message['message']!,
                    isSentByMe: message['name'] == 'You',
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 0.05,
                right: screenWidth * 0.05,
                top: screenWidth * 0.02,
                bottom: screenWidth * 0.03),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter
                          .digitsOnly, // Allow only digits
                      LengthLimitingTextInputFormatter(
                          7), // Limit length to 7 characters
                    ],
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    cursorColor: kPrimaryLightColor,
                    decoration: InputDecoration(
                      hintText: 'Add your Price Here....',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(
                          color: kPrimaryLightColor,
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(
                          color: Colors.grey[400]!,
                          width: 1.0,
                        ),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          if (_textController.text.isNotEmpty) {
                            setState(() {
                              _messages.insert(0, {
                                // Insert new messages at the beginning of the list
                                'name': 'You',
                                'message': _textController.text,
                              });
                              _textController.clear();
                            });
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.02,
                          ),
                          child: CircleAvatar(
                            backgroundColor: kPrimaryLightColor,
                            radius: 20,
                            child: Icon(
                              Icons.send,
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String name;
  final String message;
  final bool isSentByMe;

  const MessageBubble({
    Key? key,
    required this.name,
    required this.message,
    required this.isSentByMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05, vertical: screenWidth * 0.02),
      child: Align(
        alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color: isSentByMe ? kPrimaryLightColor : kPrimaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
              bottomLeft: isSentByMe ? Radius.circular(12.0) : Radius.zero,
              bottomRight: isSentByMe ? Radius.zero : Radius.circular(12.0),
            ),
          ),
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isSentByMe ? Colors.black : Colors.white,
                ),
              ),
              SizedBox(height: screenWidth * 0.01),
              Text(
                message,
                style: TextStyle(
                  color: isSentByMe ? Colors.black : Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
