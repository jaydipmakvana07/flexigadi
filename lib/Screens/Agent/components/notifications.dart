import 'package:flutter/material.dart';
import '../../../constants.dart';

class Notification {
  final String title;
  final String message;
  final IconData icon;

  Notification({
    required this.title,
    required this.message,
    required this.icon,
  });
}

class NotificationsListScreen extends StatelessWidget {
  final List<Notification> notifications = [
    Notification(
      title: 'New Booking',
      message: 'A new cab booking has been made. Please confirm it.',
      icon: Icons.local_taxi,
    ),
    Notification(
      title: 'Driver Assigned',
      message: 'A driver has been assigned for the cab booking.',
      icon: Icons.person,
    ),
    Notification(
      title: 'Feedback Received',
      message: 'A Driver has left feedback for the cab ride.',
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
              top: screenWidth * 0.05,
            ),
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
