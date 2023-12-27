import 'package:flutter/material.dart';

import '../Helper/color.dart';

class MyOrders extends StatefulWidget {
  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<MyOrders> {
  int _currentStep = 0;
  int _currentStep2 = 0;
  // int index=0;

  Widget _getStepCard(int step) {
    switch (step) {
      case 1:
        return Card(
          // color: Colors.red,
          child: Container(
            width: 300,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.remove_red_eye),
                  Container(
                    child: Image.asset('assets/images/cake12.png'),
                  ),
                  Text(
                    "Parcel Dispecth",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xffAF1919)),
                  ),
                ],
              ),
            ),
          ),
        );
      case 2:
        return Card(
          // color: Colors.red,
          child: Container(
            width: 300,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.remove_red_eye),
                  Container(
                    child: Image.asset('assets/images/cake12.png'),
                  ),
                  Text(
                    "Out for Delivery\nTrack Delivery Boy",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xffAF1919),
                        fontSize: 10),
                  ),
                  Text(
                    "Code=350\nDrop Client",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xff112C48),
                        fontSize: 10),
                  ),
                ],
              ),
            ),
          ),
        );
      case 3:
        return Card(
          // color: Colors.red,
          child: Container(
            width: 300,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15, top: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.remove_red_eye),
                  Container(
                    child: Image.asset('assets/images/cake12.png'),
                  ),
                  Text(
                    "Arrived",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xffAF1919),
                        fontSize: 15),
                  ),
                  Text(
                    "Paid=350",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xff112C48),
                        fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
        );
      default:
        return Container(); // Empty container for no card
    }
  }

  Widget _buildCard(String content) {
    return Card(
      // color: Colors.red,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Center(
          child: Text(content),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.appbarColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Container(
            height: _currentStep2 > 0 ? 320 : 250,
            width: 400,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xffEFEFEF),
                border: Border.all(color: Color(0xff112C48))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                //  mainAxisAlignment: MainAxisAlignment.center,
                //  mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomStepIndicator(
                    currentStep: _currentStep,
                    totalSteps: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Assigner\nDelivery Boy"),
                      Text("Picked          \n"),
                      Text("Out For\nDelivery"),
                      Text("Arrived\n"),
                    ],
                  ),
                  Card(
                    color: Color(0xffEFEFEF),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      // color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 60, left: 5),
                            child: Column(
                              children: [
                                Container(
                                  color: Colors.white,
                                  width: 60,
                                  height: 100,
                                  child:
                                      Image.asset('assets/images/cake12.png'),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Order No- Abc/001",
                                  style: TextStyle(
                                      color: Color(0xffAF1919),
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    "Cake",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                    "lorem lpsum is simply dummy\ntypesetting industry."),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text("₹350"),
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      child: Container(
                                        width: 100,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: Color(0xff112C48),
                                            borderRadius:
                                                BorderRadius.circular(8)),

                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Row(
                                            children: [
                                              Icon(Icons.person_outline),
                                              Text(
                                                "Raj Sharma",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10),
                                              )
                                            ],
                                          ),
                                        ),
                                        // child: Center(child: Text("Raj Sharma",style: TextStyle(color: Colors.white,fontSize: 10),)),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          if (_currentStep < 3 &&
                                              _currentStep2 < 4) {
                                            _currentStep++;
                                            _currentStep2++;

                                            _getStepCard(_currentStep);
                                          } else {
                                            _currentStep = 0;
                                            _currentStep2 = 0;
                                          }
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      width: 100,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          color: Color(0xff112C48),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Center(
                                          child: Text(
                                        "Time 2:00 to 4:00",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 10),
                                      )),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  if (_currentStep > 0) _getStepCard(_currentStep)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomStepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final double circleRadius = 10.0;
  final double lineWidth = 2.0;

  CustomStepIndicator({required this.currentStep, required this.totalSteps});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(totalSteps, (index) => buildStep(index, context)),
    );
  }

  Widget buildStep(int index, BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: circleRadius,
            backgroundColor: index == currentStep ? Colors.green : Colors.white,
            child: CircleAvatar(
              radius: circleRadius - lineWidth,
              backgroundColor:
                  index == currentStep ? Colors.green : Colors.white,
            ),
          ),
          if (index < totalSteps - 1)
            Container(
              width: 70.0,
              height: lineWidth,
              color: Colors.grey[300],
            ),
        ],
      ),
    );
  }
}
