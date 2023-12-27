import 'package:flutter/material.dart';

import 'ProductDetail.dart';

class MyCart extends StatefulWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  int selected = 0;
  List<String> productName = ["Medicine", "Vegetable", "Clothes", "Cake"];
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
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: ListView(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 0),
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    selected = 0;
                                  });
                                },
                                child: Container(
                                  //padding: EdgeInsets.symmetric(vertical: 15),
                                  decoration: BoxDecoration(
                                      color: selected == 0
                                          ? Color(0xff112C48)
                                          : Colors.white,
                                      border:
                                          Border.all(color: Color(0xff112C48)),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Text('On Going Orders',
                                        style: TextStyle(
                                          color: selected == 0
                                              ? Colors.white
                                              : Color(0xff112C48),
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    selected = 1;
                                  });
                                },
                                child: Container(
                                  //  padding: EdgeInsets.symmetric(vertical: 15),
                                  decoration: BoxDecoration(
                                      color: selected == 1
                                          ? Color(0xff112C48)
                                          : Colors.white,
                                      border:
                                          Border.all(color: Color(0xff112C48)),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Text(
                                      'Completed Orders',
                                      style: TextStyle(
                                        color: selected == 1
                                            ? Colors.white
                                            : Color(0xff112C48),
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
                            height: 10,
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails()));
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: MediaQuery.of(context).size.width * 0.15),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                            child: Text(
                              'Generate an Enquiry',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
                    ])),
          ),
        ),
      ),
    );
  }

  Widget listTileWidget({required int index}) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.orange),
          color: Colors.white,
          borderRadius: BorderRadius.circular(5)),
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
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                    style: TextStyle(fontSize: 10),
                  ),
                  Text(
                    '₹ 1200',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(
                        "4.8",
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 12,
                      ),
                      SizedBox(
                        width: 1,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 12,
                      ),
                      SizedBox(
                        width: 1,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 12,
                      ),
                      SizedBox(
                        width: 1,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 12,
                      ),
                      SizedBox(
                        width: 1,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 12,
                      ),
                    ],
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
