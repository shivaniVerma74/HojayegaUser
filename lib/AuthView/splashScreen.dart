import 'package:flutter/material.dart';
import 'package:ho_jayega_user_main/Screen/bottomScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'IntroScreen.dart';
import 'loginPage.dart';

String? finalOtp;
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    getValidation();
    super.initState();
  }

  Future getValidation() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? user_id = sharedPreferences.getString('user_id');
    print("user id in splash screen $user_id");
    finalOtp = user_id;
    _navigateToHome();
  }

  _navigateToHome() {
    Future.delayed(const Duration(seconds: 4),() {
      if (finalOtp == null || finalOtp ==  '') {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const IntroScreen()));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>  BottomNavBar()));
      }
    },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Image.asset(
          'assets/images/SPLASH SCREEN (1).png',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
