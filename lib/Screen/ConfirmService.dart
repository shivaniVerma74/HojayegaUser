import 'package:flutter/material.dart';
import 'package:ho_jayega_user_main/Screen/bottomScreen.dart';

import '../Helper/color.dart';

class ConfirmService extends StatefulWidget {
  const ConfirmService({Key? key}) : super(key: key);

  @override
  State<ConfirmService> createState() => _ConfirmServiceState();
}

class _ConfirmServiceState extends State<ConfirmService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 180),
          child: Column(
            children: [
              Image.asset(
                "assets/images/confirmed.png",
                height: 100,
                width: 100,
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Congratulations!",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 9,
              ),
              const Text(
                "Your Booking Confirmed",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 13),
              Container(
                height: 80,
                width: MediaQuery.of(context).size.width / 1.5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: colors.primary),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Column(
                      children: const [
                        Text(
                          "Time: 2:00 to 4:00",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                        Text("hair cut",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                        ),
                        Text("Rb saloon",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BottomNavBar()));
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 1.7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: colors.secondary),
                  child: const Center(
                      child: Text(
                    "Got It",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: colors.whiteTemp,
                        fontSize: 18),
                  ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
