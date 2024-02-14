import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import '../../constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../Otp/verifyscreen.dart'; // Import the OtpVerifiedScreen

// ignore: must_be_immutable
class OtpScreen extends StatefulWidget {
  String _contact;

  OtpScreen({Key? key})
      : _contact = '',
        super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget._contact = ModalRoute.of(context)!.settings.arguments as String;
      generateOtp(widget._contact);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(screenWidth * 0.06),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                const Text(
                  'Verification',
                  style: TextStyle(fontSize: 28, color: Colors.black),
                ),
                SizedBox(
                  height: screenHeight * 0.07,
                ),
                SvgPicture.asset(
                  'assets/icons/otp.svg',
                  height: screenHeight * 0.3,
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Text(
                  'Enter A 6 digit number that was sent to +9000000000${widget._contact}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenWidth > 600 ? screenWidth * 0.2 : 16),
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0),
                        blurRadius: 6.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: screenWidth * 0.01,
                            right: screenWidth * 0.01),
                        child: OtpTextField(
                          fieldWidth: screenWidth * 0.13,
                          numberOfFields: 4,
                          focusedBorderColor: kPrimaryLightColor,
                          cursorColor: kPrimaryLightColor,
                          textStyle: TextStyle(
                            fontSize: screenWidth *
                                0.05, // Adjust font size as needed
                            color: Colors.black, // Adjust color as needed
                          ),
                          onCodeChanged: (String code) {
                            // handle validation or checks here
                          },
                          onSubmit: (String verificationCode) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Verification Code"),
                                  content:
                                      Text('Code entered is $verificationCode'),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.04,
                      ),
                      GestureDetector(
                        onTap: () {
                          // Mocking the method since the backend part is removed
                          verifyOtp();
                        },
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          height: screenHeight * 0.07,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: kPrimaryLightColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Verify',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> generateOtp(String contact) async {
    // Mocking the method since the backend part is removed
    print('Generate OTP for: $contact');
  }

  Future<void> verifyOtp() async {
    // Mocking the method since the backend part is removed
    print('Verify OTP');

    // Check if OTP is valid (replace this condition with your actual verification logic)
    bool isOtpValid = true;

    if (isOtpValid) {
      // OTP is valid, navigate to the OtpVerifiedScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OtpVerifiedScreen(),
        ),
      );
      // } else {
      // Show an error message or handle invalid OTP case
      // showDialog(
      //   context: context,
      //   builder: (context) {
      //     return AlertDialog(
      //       title: Text("Error"),
      //       content: Text("Invalid OTP. Please try again."),
      //       actions: [
      //         TextButton(
      //           onPressed: () {
      //             Navigator.pop(context);
      //           },
      //           child: Text("OK"),
      //         ),
      //       ],
      //     );
      //   },
      // );
    }
  }
}
