import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ho_jayega_user_main/Helper/appBar.dart';
import 'package:ho_jayega_user_main/Helper/color.dart';

class Services extends StatefulWidget {
  const Services({Key? key}) : super(key: key);

  @override
  State<Services> createState() => _TopServiceState();
}

class _TopServiceState extends State<Services> {
  List<String> categoryList = [
    'Men Salon',
    'Beauty Parlour',
    'Unisex Salon',
    'Home Services',
    'Spa',
    'Pet Salo & Spa'
  ];
  List<String> selectList = [
    'Salon',
    'Education',
    'Pet industry',
    'Dr',
    'Home Services'
  ];
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  List<String> topServicesList = ['Vedika P&D Service', 'Rb Saloon'];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colors.appbarColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: commonAppBar(
            context,
            isHome: false,
            text: "Top Services",
          ),
        ),
        body: Container(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: ListView(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                      child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 2,
                                    offset: Offset(0, 1))
                              ]),
                          child: const TextField(
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 5),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.green,
                              ),
                              hintStyle: TextStyle(
                                fontSize: 14,
                              ),
                              hintText: "Search Services",
                              border: InputBorder.none,
                            ),
                          ))),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                      padding: const EdgeInsets.all(4.0),
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 2,
                                offset: Offset(0, 1))
                          ]),
                      child: const Center(
                          child: Text(
                        "Search By km.",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      )))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: colors.primary)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: selectList
                        .map((e) => Row(
                              children: [
                                Icon(
                                  Icons.radio_button_off_outlined,
                                  size: 12,
                                ),
                                Text(
                                  e,
                                  style: TextStyle(
                                      fontSize: 12, color: colors.primary),
                                )
                              ],
                            ))
                        .toList()),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Select category\'s',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black.withOpacity(0.8),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  primary: false,
                  padding: const EdgeInsets.all(0),
                  itemCount: categoryList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.8,
                    mainAxisSpacing: 10.0,
                  ),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          height: 120,
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/SPLASH SCREEN (1).png'),
                                  fit: BoxFit.fill),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(
                              categoryList[index],
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black.withOpacity(0.8),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Top Services',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black.withOpacity(0.8),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  primary: false,
                  padding: const EdgeInsets.all(0),
                  itemCount: topServicesList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.8,
                    mainAxisSpacing: 10.0,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              // height: 120,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/SPLASH SCREEN (1).png'),
                                      fit: BoxFit.fill),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    topServicesList[index],
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black.withOpacity(0.8),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                        size: 14,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                        size: 14,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                        size: 14,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                        size: 14,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                        size: 14,
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '2KM',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        index == 0 ? 'Open' : 'Close',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: index == 0
                                                ? Colors.green
                                                : Colors.red),
                                      )
                                    ],
                                  )
                                ],
                              ),
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
      ),
    );
  }
}
