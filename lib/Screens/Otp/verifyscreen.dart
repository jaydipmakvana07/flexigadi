import 'package:flexigadi/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../Login/login_screen.dart';

class OtpVerifiedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/icons/verify.svg", // Replace with your SVG file path
                height: screenHeight *
                    0.4, // Adjust the size based on screen height
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Text(
                'OTP Verified Successfully',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: screenHeight * 0.07,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: defaultPadding *
                        2), // Adjust the horizontal padding as needed
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the login screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const LoginScreen();
                        },
                      ),
                    );

                    // Replace with your login route
                  },
                  child: Text('LOGIN NOW'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
