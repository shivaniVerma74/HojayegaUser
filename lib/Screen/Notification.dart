import 'package:flutter/material.dart';

class notificationPage extends StatefulWidget {
  const notificationPage({Key? key}) : super(key: key);
  @override
  State<notificationPage> createState() => _notificationPageState();
}
class _notificationPageState extends State<notificationPage> {
  List<String> listDetails = [
    "Vikas agrawal",
    "Bob John",
    "Niraj Vyas",
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Scaffold(
        // key: _key,
          appBar: AppBar(
            backgroundColor:Color(0xff112C48),
            title: const Text(
              "Notification",
              style: TextStyle(color: Colors.white),
            ),

            centerTitle: true,
            toolbarHeight: 70,
            elevation: 6,

          ),
          body: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: ListView(
                  children: [
                    Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.black.withOpacity(0.3))),
                        child: const TextField(
                          maxLines: 1,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            hintText: "Search",
                            border: InputBorder.none,
                          ),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: ListView(physics: BouncingScrollPhysics(), children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            alignment:Alignment.centerLeft,child:Text('Today')),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            alignment: Alignment.centerRight, child: Text('Clear All')),
                        SizedBox(
                          height: 10,
                        ),
                        ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: listDetails.length,
                          itemBuilder: (context, index) {
                            return listTileWidget(index: index);
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 10,
                            );
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ]
                      ),

                    )
                  ]
              )
          )
      ),
    );
  }

  Widget listTileWidget({required int index}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 5),
            child: CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage('assets/images/notification image.png'),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  listDetails[index],
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Text(
                    'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  'Just Now',
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

