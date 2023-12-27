import 'package:flutter/material.dart';

class MyBooking extends StatefulWidget {
  const MyBooking({Key? key}) : super(key: key);

  @override
  State<MyBooking> createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> {
  int selected = 0;
  List<String> productName = [
    "Veika P&D Service",
    "Rb Saloon",
    "Siya Saloon",
    "Vedik Toys"
  ];
  List<String> imageList = [
    "assets/images/icon3.png",
    "assets/images/icon3.png",
    "assets/images/icon3.png",
    "assets/images/icon3.png"
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffE2EBFE), //colors.bgColor,
        body: Center(
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'My Booking History',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: imageList.length,
                      itemBuilder: (context, index) {
                        return listTileWidget(index: index);
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 20,
                        );
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ])),
        ),
      ),
    );
  }

  Widget listTileWidget({required int index}) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Container(
                padding: EdgeInsets.only(left: 10),
                child: Image(image: AssetImage(imageList[index]))),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName[index],
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  // Text(
                  //   'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  //   style: TextStyle(fontSize: 12),
                  // ),
                  Row(
                    children: [
                      Icon(
                        Icons.pin_drop,
                        color: Colors.red,
                        size: 16,
                      ),
                      Text(
                        'Vijay Nagar Indore',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '₹ 1200',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '15 November 2023',
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          index == 1
                              ? 'Rejected'
                              : index == 2
                                  ? 'Cancelled'
                                  : 'Completed',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: index == 1
                                  ? Colors.red
                                  : index == 2
                                      ? Colors.black
                                      : Colors.green),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
