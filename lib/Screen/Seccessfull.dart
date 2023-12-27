import 'package:flutter/material.dart';
import '../Helper/color.dart';
import 'bottomScreen.dart';

class Successfully extends StatefulWidget {
  const Successfully({Key? key}) : super(key: key);

  @override
  State<Successfully> createState() => _SuccessfullyState();
}

class _SuccessfullyState extends State<Successfully> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.appbarColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 80),
            Image.asset("assets/images/success.png"),
            const Text("Thank-you Payment Successful", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),),
            const SizedBox(height: 5),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text("Lorem ipsum dolor sit amet consecrate elite, sed diam \n Lorem ipsum dolor sit amet, consecrate elite, sed diam",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black),),
            ),
           const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavBar()));
              },
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width/1.8,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: colors.secondary),
                child: const Center(
                  child: Text("Done",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: colors.appbarColor),
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
