import 'package:flutter/material.dart';

import '../Helper/color.dart';

class termsAndCondition extends StatefulWidget {
  const termsAndCondition({Key? key}) : super(key: key);

  @override
  State<termsAndCondition> createState() => _termsAndConditionState();
}

class _termsAndConditionState extends State<termsAndCondition> {
  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
        child:Scaffold(
          // key: _key,
            appBar: AppBar(
              backgroundColor:const Color(0xff112C48),
              title: const Text(
                "Terms & Conditions",
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              toolbarHeight: 70,
              elevation: 6,
            ),
            body: Container(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                decoration: const BoxDecoration(
                  // const BorderRadius.all(Radius.Radius),
                  border: Border(
                    top: BorderSide(
                      //  BorderRadius.all(Radius.Radius),
                      color: colors.primary,
                      width: 1,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        "Our Terms & Conditions",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      // subtitle: Text(
                      //   "Last update january 2022",
                      //   style: TextStyle(fontSize: 10),
                      // ),
                    ),
                    Container(
                      height: 1,
                      color: Colors.grey,
                      width: MediaQuery.of(context).size.width,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        '1. Using our Service',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Lorem Ipsum is simply dummy text of the Lorem Ipsum is simply dummy text of the and typesetting industry. Lorem Ipsum Lorem Ipsum is simply dummy text of the Lorem Ipsum is simply dummy text of the Lorem Ipsum is simply dummy and typesetting industry. Lorem Ipsum industry\'s standard dummy when an unknown printer took a galley of type and scrambled it and typesetting industry. Lorem Ipsum industry\'s standard dummy since the 1500s, when an unknown printer took a galley of type',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        '2. Using our Service',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Lorem Ipsum is simply dummy text of the Lorem Ipsum is simply dummy text of the and typesetting industry. Lorem Ipsum Lorem Ipsum is simply dummy text of the Lorem Ipsum is simply dummy text of the Lorem Ipsum is simply dummy and typesetting industry. Lorem Ipsum industry\'s standard dummy when an unknown printer took a galley of type and scrambled it and typesetting industry. Lorem Ipsum industry\'s standard dummy since the 1500s, when an unknown printer took a galley of type',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                  ],
                )
            )
        )
    );
  }
}

