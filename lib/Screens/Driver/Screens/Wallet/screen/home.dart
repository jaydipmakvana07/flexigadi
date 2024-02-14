import 'package:flutter/material.dart';
import '../../Home/screens/homescreen.dart';
import '../../../../../constants.dart';
import '../../Wallet/screen/addcoin.dart';

class WalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet'),
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace), // Change icon to home icon
          onPressed: () {
            // Navigate to the home screen
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => HomedriverScreen(),
            ));
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: screenWidth * 0.07,
                  right: screenWidth * 0.07,
                  top: screenWidth * 0.05,
                  bottom: screenWidth * 0.05),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                    blurRadius: 1.0,
                    spreadRadius: 2.0,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth * 0.05, top: screenWidth * 0.02),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            '100.00',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.13,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        Container(
                          width: screenWidth * 0.13,
                          height: screenWidth * 0.13,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: kPrimaryLightColor,
                            border: Border.all(
                              color: Colors.white,
                              width: screenWidth * 0.004,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "₹",
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: screenWidth * 0.07,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.01),
                  Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth * 0.07, top: screenWidth * 0.02),
                    child: Text(
                      'DRIVER NAME', // Replace with actual username
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.06),
                  ElevatedButton(
                    onPressed: () {
                      // Implement add money functionality
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => AddMoneyScreen(),
                      ));
                    },
                    child: Text('ADD COINS'),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenWidth * 0.06),
            Padding(
              padding: EdgeInsets.only(
                  left: screenWidth * 0.01, bottom: screenWidth * 0.02),
              child: Text(
                'Transaction History',
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Change color as desired
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10, // Replace with actual transaction count
                itemBuilder: (context, index) {
                  // Replace with actual transaction data
                  bool isDeposit = index % 2 == 0;
                  String amount = isDeposit ? '+50' : '-20';
                  String status = isDeposit ? 'Added Coins' : 'Withdrawal';
                  String date = '12 Feb'; // Replace with actual date
                  return ListTile(
                    title: Row(
                      children: [
                        Text(
                          date,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          status,
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          amount,
                          style: TextStyle(
                            color: isDeposit ? closedgreen : activered,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
