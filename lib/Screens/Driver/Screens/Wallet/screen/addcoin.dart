import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upi_india/upi_india.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../constants.dart';

class AddMoneyScreen extends StatefulWidget {
  @override
  _AddMoneyScreenState createState() => _AddMoneyScreenState();
}

class _AddMoneyScreenState extends State<AddMoneyScreen> {
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Money'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: screenWidth * 0.7, // Height of your SVG
                child: SvgPicture.asset(
                  "assets/icons/driver.svg",
                ),
              ),
              SizedBox(height: screenWidth * 0.02),
              Text(
                'SEND MONEY TO',
                style: TextStyle(
                  fontSize: screenWidth * 0.08,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenWidth * 0.01),
              Text(
                'jaydipmakvana7777-1@oksbi',
                style: TextStyle(
                    fontSize: screenWidth * 0.04, color: kPrimaryColor),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenWidth * 0.07),
              Padding(
                padding: EdgeInsets.only(
                    left: screenWidth * 0.05,
                    right: screenWidth * 0.05), // Adjust padding as needed
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'[0-9.]')), // Allow only digits and dot
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      try {
                        final text = newValue.text;
                        if (text.isNotEmpty) double.parse(text);
                        return newValue;
                      } catch (e) {
                        return oldValue;
                      }
                    }),
                  ],
                  style: TextStyle(
                      fontSize: screenWidth * 0.04), // Setting font size to 20
                  decoration: InputDecoration(
                    labelText: 'Enter Amount',
                    filled: true, // Filling the background color
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: kPrimaryLightColor,
                      ),
                    ),
                    // Setting background color to white
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black), // Setting border color to black
                    ),
                  ),
                  cursorColor: kPrimaryLightColor, // Setting cursor color
                ),
              ),
              SizedBox(height: screenWidth * 0.01),
              Container(
                margin: EdgeInsets.symmetric(vertical: screenWidth * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        _amountController.text = '100';
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(kPrimaryColor),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                        textStyle: MaterialStateProperty.all(
                          TextStyle(fontSize: 16),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      child: Text('100'),
                    ),
                    TextButton(
                      onPressed: () {
                        _amountController.text = '200';
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(kPrimaryColor),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                        textStyle: MaterialStateProperty.all(
                          TextStyle(fontSize: 16),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      child: Text('200'),
                    ),
                    TextButton(
                      onPressed: () {
                        _amountController.text = '500';
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(kPrimaryColor),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                        textStyle: MaterialStateProperty.all(
                          TextStyle(fontSize: 16),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      child: Text('500'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenWidth * 0.04),
              ElevatedButton(
                onPressed: () {
                  _proceedWithPayment();
                },
                child: Text('NEXT'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _proceedWithPayment() async {
    // Get the amount from the text field
    String amountText = _amountController.text.trim();
    if (amountText.isNotEmpty) {
      // Convert the amount to double
      double amount = double.tryParse(amountText) ?? 0.0;
      if (amount > 0) {
        // Proceed with UPI payment
        UpiIndia upiIndia = UpiIndia();
        List<UpiApp>? apps = await upiIndia.getAllUpiApps();
        // ignore: unnecessary_null_comparison
        if (apps != null && apps.isNotEmpty) {
          // Show the list of all UPI apps and let the user choose one
          UpiApp? chosenApp = await showDialog<UpiApp?>(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Choose UPI App'),
              content: SingleChildScrollView(
                child: Column(
                  children: apps.map((app) {
                    return ListTile(
                      title: Text(app.name),
                      onTap: () {
                        Navigator.of(context).pop(app);
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
          );

          if (chosenApp != null) {
            // Start transaction with the chosen UPI app
            UpiResponse? response = await upiIndia.startTransaction(
              app: chosenApp,
              receiverName:
                  'MAKWANA BHARGAVKUMAR NILESHBHAI', // Replace with actual receiver name
              receiverUpiId:
                  '9978863413@paytm', // Replace with actual receiver UPI ID
              transactionRefId:
                  'TestingUpiIndiaPlugin', // Replace with your transaction reference
              transactionNote:
                  'Payment for adding money', // Replace with transaction note
              amount: amount, // Format amount to two decimal places
            );
            // ignore: unnecessary_null_comparison
            if (response != null) {
              // Handle the response as needed
              print('UPI Transaction ID: ${response.transactionId}');
              print('UPI Response Code: ${response.responseCode}');
              print('UPI Approval Reference Number: ${response.approvalRefNo}');
              // Check the responseCode to determine the success or failure of the transaction
            }
          }
        } else {
          // No UPI apps installed, prompt user to install one
          _showErrorMessage(
              'No UPI apps found. Please install a UPI app to proceed with payment.');
        }
      } else {
        // Show error message if the input is invalid
        _showErrorMessage('Invalid amount');
      }
    } else {
      // Show error message if the input is empty
      _showErrorMessage('Please enter an amount');
    }
  }

  void _showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    home: AddMoneyScreen(),
  ));
}
