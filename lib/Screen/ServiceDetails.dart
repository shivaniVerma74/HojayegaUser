import 'package:flutter/material.dart';
import 'package:ho_jayega_user_main/Screen/AppoinementBooking.dart';

import '../Helper/color.dart';

class ServiceDetails extends StatefulWidget {
  const ServiceDetails({super.key});

  @override
  State<ServiceDetails> createState() => _RbSaloonState();
}

class _RbSaloonState extends State<ServiceDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colors.appbarColor,
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: colors.primary,
          foregroundColor: Colors.white,//(0xff112C48),
          title: const Text('Service Details'),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20.0)
            ),
          ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(top: 25, right: 10),
            child: Text('data', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    'Beauty Parlour',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              height: 140,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              height: 100,
                              width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                // border: Border.all(color: Colors.black),
                                // color: Colors.red,
                              ),
                              child: Image.asset(
                                'assets/unnamed.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            const Text("teststtst")
                          ],
                        ));
                  }),
            ),
            Container(
              height: size.height * 0.64,
              width: size.height * 0.44,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color(0XFF112c48),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20, top: 10),
                    child: Text(
                      'Hair Service',
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0XFF112c40),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5, right: 10),
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(right: 3, left: 10),
                          child: Icon(
                            Icons.circle,
                            size: 10,
                          ),
                        ),
                        Text(
                          'Haircut',
                          style:
                              TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                        ),
                        Spacer(),
                        Text(
                          '350/-',
                          style:
                              TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5, right: 3),
                          child: Icon(
                            Icons.circle,
                            size: 22,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5, right: 10),
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(right: 3, left: 10),
                          child: Icon(
                            Icons.circle,
                            size: 10,
                          ),
                        ),
                        Text(
                          'Hair Wash',
                          style:
                              TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                        ),
                        Spacer(),
                        Text(
                          '100/-',
                          style:
                              TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5, right: 3),
                          child: Icon(
                            Icons.circle,
                            size: 22,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5, right: 10),
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(right: 3, left: 10),
                          child: Icon(
                            Icons.circle,
                            size: 10,
                          ),
                        ),
                        Text(
                          'Hair Spa',
                          style:
                              TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                        ),
                        Spacer(),
                        Text(
                          '500/-',
                          style:
                              TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5, right: 3),
                          child: Icon(
                            Icons.circle,
                            size: 22,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5, right: 10),
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(right: 3, left: 10),
                          child: Icon(
                            Icons.circle,
                            size: 10,
                          ),
                        ),
                        Text(
                          'Hair Color Touch Up',
                          style:
                              TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                        ),
                        Spacer(),
                        Text(
                          '300/-',
                          style:
                              TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5, right: 3),
                          child: Icon(
                            Icons.circle,
                            size: 22,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20, top: 10),
                    child: Text(
                      'Grooming',
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0XFF112c40),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5, right: 10),
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 10, right: 3),
                          child: Icon(
                            Icons.circle,
                            size: 10,
                          ),
                        ),
                        Text(
                          'Shaving',
                          style:
                              TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                        ),
                        Spacer(),
                        Text(
                          '350/-',
                          style:
                              TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5, right: 3),
                          child: Icon(
                            Icons.circle,
                            size: 22,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5, right: 10),
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(right: 3, left: 10),
                          child: Icon(
                            Icons.circle,
                            size: 10,
                          ),
                        ),
                        Text(
                          'Nail Spa',
                          style:
                              TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                        ),
                        Spacer(),
                        Text(
                          '100/-',
                          style:
                              TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5, right: 3),
                          child: Icon(
                            Icons.circle,
                            size: 22,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5, right: 10),
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(right: 3, left: 10),
                          child: Icon(
                            Icons.circle,
                            size: 10,
                          ),
                        ),
                        Text(
                          'Groomin Feet',
                          style:
                              TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                        ),
                        Spacer(),
                        Text(
                          '500/-',
                          style:
                              TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5, right: 3),
                          child: Icon(
                            Icons.circle,
                            size: 22,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5, right: 10),
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(right: 3, left: 10),
                          child: Icon(
                            Icons.circle,
                            size: 10,
                          ),
                        ),
                        Text(
                          'Grooming Hand',
                          style:
                              TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                        ),
                        Spacer(),
                        Text(
                          '300/-',
                          style:
                              TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5, right: 3),
                          child: Icon(
                            Icons.circle,
                            size: 22,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20, top: 10),
                    child: Text(
                      'Combo Offer',
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0XFF112c40),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25, right: 30),
                    child: Row(
                      children: const [
                        Text(
                          'Shaving + hair color +\n hair wash',
                          style:
                              TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                        ),
                        Spacer(),
                        Text(
                          '500/-',
                          style:
                              TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Container(
                      height: 30,
                      width: 280,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: Center(
                        child: const Text(
                          'Note:rate might change as per work',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentBooking()));
                    },
                    child: Center(
                      child: Container(
                        height: 40,
                        width: 270,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            color: Colors.green),
                        child: const Center(
                            child: Text(
                          'Book',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
