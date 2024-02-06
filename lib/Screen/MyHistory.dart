import 'package:flutter/material.dart';

class MyHistory extends StatefulWidget {
  const MyHistory({super.key});

  @override
  State<MyHistory> createState() => _MyHistoryState();
}

class _MyHistoryState extends State<MyHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
        ),
        title: Text(
          'My History',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF112c48),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          separatorBuilder: (context, index) =>
              Divider(color: Colors.transparent, height: 8),
          itemCount: 12,
          itemBuilder: (context, index) => Card(
            color: Colors.white,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                  ),
                  const VerticalDivider(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Order Id : 123456",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Cash",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "November 26, 2023",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    "+200",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
