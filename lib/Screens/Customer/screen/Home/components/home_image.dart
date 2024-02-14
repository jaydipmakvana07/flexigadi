import 'package:flexigadi/Screens/Customer/screen/Requirement/components/addrequirement.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../../../constants.dart';

class HomeImage extends StatefulWidget {
  @override
  _HomeImageState createState() => _HomeImageState();
}

class _HomeImageState extends State<HomeImage> {
  final List<String> _imageUrls = [
    'https://picsum.photos/id/1022/536/354',
    'https://picsum.photos/id/1023/536/354',
    'https://picsum.photos/id/1024/536/354',
    'https://picsum.photos/id/1025/536/354',
    'https://picsum.photos/id/1026/536/354',
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final imageHeight = screenSize.height * 0.3;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor, // Set your desired AppBar color
        // Removed the title text
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [kPrimaryColor, kPrimaryColor, Colors.white, Colors.white],
            stops: [0, 0.3, 0, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(screenSize.width * 0.05),
              padding: EdgeInsets.all(screenSize.width * 0.02),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: CarouselSlider.builder(
                itemCount: _imageUrls.length,
                options: CarouselOptions(
                  height: imageHeight,
                  viewportFraction: 1.0,
                  autoPlay: true, // Enable automatic sliding
                  autoPlayInterval:
                      Duration(seconds: 2), // Set the interval duration
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                itemBuilder: (context, index, realIndex) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: screenSize.height * 0.005,
                        horizontal: screenSize.width * 0.01),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        _imageUrls[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _imageUrls.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentIndex = entry.key;
                    });
                  },
                  child: Container(
                    width: screenSize.width * 0.02,
                    height: screenSize.height * 0.02,
                    margin: EdgeInsets.symmetric(
                        vertical: screenSize.height * 0.005,
                        horizontal: screenSize.width * 0.01),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == entry.key
                          ? kPrimaryLightColor
                          : lightBlack,
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(
                height: screenSize.width * 0.2), // Adjust the spacing as needed
            Container(
              height: screenSize.width * 0.2,
              padding: EdgeInsets.all(screenSize.width * 0.025),
              margin: EdgeInsets.only(
                  left: screenSize.width * 0.1, right: screenSize.width * 0.1),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddRequirementScreen()),
                  ); // Add your button onPressed logic here
                },
                child: Text(
                  'ADD NEW REQUIREMENT ',
                  style: TextStyle(
                    fontSize: screenSize.width * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
