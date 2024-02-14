import 'package:flutter/material.dart';
import '../../../constants.dart';

class Notification {
  final String title;
  final String message;
  final IconData icon;

  Notification(
      {required this.title, required this.message, required this.icon});
}

class NotificationsListScreen extends StatelessWidget {
  final List<Notification> notifications = [
    Notification(
      title: 'New Order',
      message: 'You have received a new order. Please confirm it.',
      icon: Icons.directions_car_filled,
    ),
    Notification(
      title: 'Reminder',
      message: 'Don\'t forget to complete your current trip.',
      icon: Icons.access_time,
    ),
    Notification(
      title: 'Feedback Received',
      message: 'A passenger has left feedback for your service.',
      icon: Icons.feedback,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 0.05,
                right: screenWidth * 0.05,
                top: screenWidth * 0.05), // Adjust the padding here
            child: Container(
              padding: EdgeInsets.all(screenWidth * 0.02),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                leading: Icon(
                  notifications[index].icon,
                  color: kPrimaryLightColor,
                ),
                title: Text(
                  notifications[index].title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(notifications[index].message),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _showDeleteConfirmationDialog(context, index);
                  },
                  color: kPrimaryColor,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Notification'),
          content: Text('Are you sure you want to delete this notification?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteNotification(index);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _deleteNotification(int index) {
    notifications.removeAt(index);
  }
}

void main() {
  runApp(MaterialApp(
    home: NotificationsListScreen(),
  ));
}
