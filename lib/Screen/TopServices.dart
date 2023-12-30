import 'package:flutter/material.dart';

class TopService extends StatefulWidget {
  const TopService({Key? key}) : super(key: key);

  @override
  State<TopService> createState() => _Project1State();
}

class _Project1State extends State<TopService> {
  var TextList1 = [
    'Men Salon',
    'Beauty Parlour',
    'Unisex Salon',
    'Men Salon',
    'Unisex Salon',
    'Men Salon',
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: Drawer(child: Text('menu')),
      backgroundColor: Color(0xFFE2EBFE),
      appBar: AppBar(
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 30, bottom: 20),
            child: CircleAvatar(
              backgroundImage: AssetImage(
                  'assets/images/girl.png'), // Replace with your image path
            ),
          ),
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
        ),
        title: const Padding(
          padding: EdgeInsets.only(bottom: 30),
          child: Text('Top Services '),
        ),
        backgroundColor: const Color(0xFF112c48),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xFFFFFFFF),
                    ),
                    child: Center(
                      child: Text(
                        'Search Services....',
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ),
                    height: 35,
                    width: 200,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xFF2BA530),
                    ),
                    child: Center(
                      child: Text(
                        'Search by Km.',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                        ),
                      ),
                    ),
                    height: 40,
                    width: 80,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 27, right: 27),
                child: Container(
                  height: 28,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(6),
                    color: Color(0xFFFFFFFF),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.circle_rounded, size: 15),
                      Text(
                        "salon",
                        style: TextStyle(fontSize: 10),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(Icons.circle_rounded, size: 15),
                      Text(
                        "Education",
                        style: TextStyle(fontSize: 10),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(Icons.circle_rounded, size: 15),
                      Text(
                        "Pet Industry",
                        style: TextStyle(fontSize: 10),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(Icons.circle_rounded, size: 15),
                      Text(
                        "Dr",
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(Icons.circle_rounded, size: 15),
                      Text(
                        "Home Services",
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text("Select Category's",
                        style:
                            TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: size.height * 0.33,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 6,
                          itemExtent: 125,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: Image.asset('assets/images/girl.png'),
                                ),
                                Text(TextList1[index],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Container(
                        height: size.height * 0.18,
                        child: Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 6,
                            itemExtent: 125,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Container(
                                    // height: ,
                                    width: double.infinity,
                                    child: Image.asset('assets/images/girl.png'),
                                  ),
                                  Text(TextList1[index],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text("Top Services",
                        style:
                            TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                height: 260,
                width: double.infinity,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      mainAxisExtent: 250),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(12),
                                topLeft: Radius.circular(12)),
                            color: Colors.white),
                        child: Column(
                          children: [
                            Image.asset('assets/images/girl.png', height: 180),
                            const Text(
                              'RB saloon',
                              style: TextStyle(fontSize: 13),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const [
                                Text(
                                  '2KM',
                                  style: TextStyle(fontSize: 13),
                                ),
                                Text(
                                  'open',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
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
      ),
    );
  }
}
