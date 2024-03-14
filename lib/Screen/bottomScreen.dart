import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:ho_jayega_user_main/Helper/api.path.dart';
import 'package:ho_jayega_user_main/Screen/Aboutus.dart';
import 'package:ho_jayega_user_main/Screen/HelpAndSupport.dart';
import 'package:ho_jayega_user_main/Screen/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../AuthView/loginPage.dart';
import '../Helper/appBar.dart';
import '../Helper/color.dart';
import 'AllCategory.dart';
import 'Cart.dart';
import 'MyBooking.dart';
import 'MyCart.dart';
import 'MyOder.dart';
import 'MyProfile.dart';
import 'Notification.dart';
import 'OrderListing.dart';
import 'PickAndDrop.dart';
import 'PrivacyPolicy.dart';
import 'TermsAndCondition.dart';
import 'faqs.dart';

class BottomNavBar extends StatefulWidget {
  int? dIndex = 0;
  BottomNavBar({super.key, this.dIndex});
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  Widget? _child;
  int selectedIndex = 0;
  int currentIndex = 99;
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  @override
  void initState() {
    int? index = widget.dIndex;
    if (index == 0) {
      setState(() {
        selectedIndex = 0;
      });
      _child = selectedIndex == 0 ? HomeScreen() : Container();
    } else {
      _child = Container();
    }
    super.initState();
    // if (widget.dIndex != null) {
    //   selectedIndex = widget.dIndex!;
    //   _child = widget.dIndex == 1
    //       ? Container()
    //       : widget.dIndex == 3
    //           ? Container()
    //           : Container();
    // } else {
    //   _child = Container();
    // }
    // super.initState();
  }

  final List<Widget> _pages = [
    HomeScreen(),
    Cart(),
    MyOrders(),
    MyBooking(),
    PickDrop()
  ];

  @override
  Widget build(BuildContext context) {
    selectedIndex = widget.dIndex ?? 0;
    return SafeArea(
        child: WillPopScope(
      onWillPop: () async {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Confirm Exit"),
                content: Text("Are you sure you want to exit?"),
                actions: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: colors.primary),
                    child: Text("YES"),
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: colors.primary),
                    child: Text("NO"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
        return true;
      },
      child: Scaffold(
        key: _key,
        backgroundColor: colors.appbarColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: selectedIndex == 0
              ? homeAppBar(
                  context,
                  text: "Home",
                  ontap: () {
                    _key.currentState?.openDrawer();
                  },
                )
              : commonAppBar(context,
                  isHome: true,
                  text: selectedIndex == 1
                      ? "My Cart"
                      : selectedIndex == 3
                          ? "My Bookings"
                          : selectedIndex == 4
                              ? "Pick & Drop"
                              : "My Orders", ontap: () {
                  _key.currentState?.openDrawer();
                }),
        ),
        body: _pages[selectedIndex],
        drawer: Drawer(
          child: ListView(children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                  // border: Border(bottom: BorderSide(color: Colors.black)),
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xff112C48), Color(0xff112C48)])),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  const CircleAvatar(
                    backgroundImage: AssetImage(
                      "assets/images/bike.png",
                    ),
                    radius: 40,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Hello!',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      user_name == null || user_name == ""
                          ? const Text(
                              'Demo',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            )
                          : Text(
                              '$user_name',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                    ],
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  currentIndex = 1;
                });
              },
              child: DrawerIconTab(
                titlee: 'Home',
                icon: Icons.home,
                tabb: 1,
                indexx: currentIndex,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const  OfferJobWidget()),
                  // );
                  setState(() {
                    currentIndex = 2;
                  });
                },
                child: DrawerIconTab(
                    titlee: 'My favorite',
                    icon: Icons.file_present_outlined,
                    tabb: 2,
                    indexx: currentIndex)),
            SizedBox(
              height: 5,
            ),
            InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyProfile()),
                  );
                  setState(() {
                    currentIndex = 3;
                  });
                },
                child: DrawerIconTab(
                    titlee: 'My Account',
                    icon: Icons.file_copy,
                    tabb: 3,
                    indexx: currentIndex)),
            // SizedBox(
            //   height: 5,
            // ),
            // InkWell(
            //     onTap: () {
            //       // Navigator.push(
            //       //   context,
            //       //   MaterialPageRoute(
            //       //       builder: (context) => const  CoursesPage()),
            //       // );
            //       setState(() {
            //         currentIndex = 4;
            //       });
            //     },
            //     child: DrawerIconTab(
            //       titlee: 'Become a merchant',
            //       icon: Icons.file_copy,
            //       tabb: 4,
            //       indexx: currentIndex,
            //     )),
            SizedBox(
              height: 5,
            ),
            InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const  MyBooking()),
                  // );
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavBar(dIndex: 3)),
                  );
                  // selectedIndex = 3;
                  // setState(() {
                  //   currentIndex = 5;
                  // });
                },
                child: DrawerIconTab(
                  titlee: 'My Bookings',
                  icon: Icons.file_copy,
                  tabb: 5,
                  indexx: currentIndex,
                )),
            SizedBox(
              height: 5,
            ),
            InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) =>  MyOrders()),
                  // );
                  _handleNavigationChange(2);
                  setState(() {
                    currentIndex = 6;
                  });
                },
                child: DrawerIconTab(
                  titlee: 'My Orders',
                  icon: Icons.payment,
                  tabb: 6,
                  indexx: currentIndex,
                )),
            SizedBox(
              height: 5,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Cart()),
                );
                setState(() {
                  currentIndex = 7;
                });
              },
              child: DrawerIconTab(
                titlee: 'My Cart',
                icon: Icons.my_library_books_sharp,
                tabb: 7,
                indexx: currentIndex,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyProfile()),
                  );
                  setState(() {
                    currentIndex = 8;
                  });
                },
                child: DrawerIconTab(
                  titlee: 'My Profile',
                  icon: Icons.headphones,
                  tabb: 8,
                  indexx: currentIndex,
                )),
            const SizedBox(
              height: 5,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationScreen()),
                );
                setState(() {
                  currentIndex = 9;
                });
              },
              child: DrawerIconTab(
                titlee: 'Notification',
                icon: Icons.privacy_tip,
                tabb: 9,
                indexx: currentIndex,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const TermsConditionsWidget()),
                  // );
                  setState(() {
                    currentIndex = 10;
                  });
                  share();
                },
                child: DrawerIconTab(
                  titlee: 'Share the app',
                  icon: Icons.confirmation_num,
                  tabb: 10,
                  indexx: currentIndex,
                )),
            // SizedBox(
            //   height: 5,
            // ),
            // InkWell(
            //     onTap: () {
            //       // Navigator.push(
            //       //   context,
            //       //   MaterialPageRoute(
            //       //       builder: (context) => const FaqPage()),
            //       // );
            //
            //       setState(() {
            //         currentIndex = 11;
            //       });
            //     },
            //     child: DrawerIconTab(
            //       titlee: 'Send Feedback',
            //       icon: Icons.question_answer,
            //       tabb: 11,
            //       indexx: currentIndex,
            //     )),
            // SizedBox(
            //   height: 5,
            // ),
            // InkWell(
            //     onTap: () {
            //       // Navigator.push(
            //       //   context,
            //       //   MaterialPageRoute(
            //       //       builder: (context) => const LoginPage()),
            //       // );
            //
            //       setState(() {
            //         currentIndex = 12;
            //       });
            //     },
            //     child: DrawerIconTab(
            //       titlee: 'Refer & Earn',
            //       icon: Icons.question_answer,
            //       tabb: 12,
            //       indexx: currentIndex,
            //     )),
            SizedBox(
              height: 5,
            ),
            InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HelpScreen()),
                  );
                  setState(() {
                    currentIndex = 13;
                  });
                },
                child: DrawerIconTab(
                  titlee: 'Help & Support',
                  icon: Icons.question_answer,
                  tabb: 13,
                  indexx: currentIndex,
                )),
            SizedBox(
              height: 5,
            ),
            InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AboutUS()),
                  );
                  setState(() {
                    currentIndex = 14;
                  });
                },
                child: DrawerIconTab(
                  titlee: 'About Us',
                  icon: Icons.question_answer,
                  tabb: 14,
                  indexx: currentIndex,
                )),
            const SizedBox(
              height: 5,
            ),
            InkWell(
                onTap: () {
                  setState(() {
                    currentIndex = 15;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PrivacyPolicyScreen(),
                      ));
                },
                child: DrawerIconTab(
                  titlee: 'Privacy Policy',
                  icon: Icons.policy,
                  tabb: 15,
                  indexx: currentIndex,
                )),
            // const SizedBox(
            //   height: 5,
            // ),
            // InkWell(
            //     onTap: () {
            //       setState(() {
            //         currentIndex = 16;
            //       });
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => termsAndCondition(),
            //           ));
            //     },
            //     child: DrawerIconTab(
            //       titlee: 'Terms & Conditions',
            //       icon: Icons.policy_outlined,
            //       tabb: 16,
            //       indexx: currentIndex,
            //     )),
            const SizedBox(
              height: 5,
            ),
            InkWell(
                onTap: () {
                  setState(() {
                    currentIndex = 17;
                  });

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FaqPage(),
                      ));
                },
                child: DrawerIconTab(
                  titlee: 'FAQ',
                  icon: Icons.podcasts_sharp,
                  tabb: 17,
                  indexx: currentIndex,
                )),
            const SizedBox(
              height: 5,
            ),
            InkWell(
                onTap: () {
                  setState(() {
                    currentIndex = 18;
                  });
                  logout(context);
                },
                child: DrawerIconTab(
                  titlee: 'Log Out',
                  icon: Icons.logout_outlined,
                  tabb: 18,
                  indexx: currentIndex,
                )),
            const SizedBox(
              height: 20,
            ),
          ]),
        ),
        bottomNavigationBar: FluidNavBar(
          icons: [
            FluidNavBarIcon(
                icon: Icons.home,
                // unselectedForegroundColor: Colors.grey,
                selectedForegroundColor: Colors.white,
                //  svgPath: "assets/home.svg",
                backgroundColor: colors.primary,
                unselectedForegroundColor: Colors.white,
                //  selectedIndex == 1 ? colors.primary : colors.white10,
                extras: {"label": "Home"}),
            FluidNavBarIcon(
                // unselectedForegroundColor: Colors.grey,
                selectedForegroundColor: Colors.white,
                icon: Icons.shopping_cart,
                backgroundColor: colors.primary,
                unselectedForegroundColor: Colors.white,
                //  selectedIndex == 1 ? colors.primary : colors.white10,
                extras: {"label": "My Cart"}),
            FluidNavBarIcon(
                icon: Icons.list_alt_sharp,
                // unselectedForegroundColor: Colors.grey,
                selectedForegroundColor: Colors.white,
                unselectedForegroundColor: Colors.white,
                backgroundColor: colors.primary,
                //  selectedIndex == 1 ? colors.primary : colors.white10,
                extras: {"label": "My Orders"}),
            FluidNavBarIcon(
                icon: Icons.calendar_month,
                // unselectedForegroundColor: Colors.grey,
                selectedForegroundColor: Colors.white,
                backgroundColor: colors.primary,
                unselectedForegroundColor: Colors.white,
                //  selectedIndex == 1 ? colors.primary : colors.white10,
                extras: {"label": "My Bookings"}),
            FluidNavBarIcon(
                icon: Icons.wheelchair_pickup,
                // unselectedForegroundColor: Colors.grey,
                selectedForegroundColor: Colors.white,
                unselectedForegroundColor: Colors.white,
                backgroundColor: colors.primary,
                //  selectedIndex == 1 ? colors.primary : colors.white10,
                extras: {"label": "Pick & Drop"}),
          ],
          onChange: _handleNavigationChange,
          style: FluidNavBarStyle(
            barBackgroundColor: colors.primary,
          ),
          scaleFactor: 1.2,
          defaultIndex: selectedIndex,
          animationFactor: 0.5,
          itemBuilder: (icon, item) => Semantics(
            label: icon.extras!["label"],
            container: true,
            enabled: true,
            child: Stack(
              children: [
                item,
                Container(
                  width: MediaQuery.of(context).size.width * 0.25 - 25,
                  margin: EdgeInsets.only(top: 40),
                  child: Center(
                    child: Text(
                      icon.extras!["label"],
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'HoJayega',
        // text: 'Example share text',
        linkUrl: 'https://developmentalphawizz.com/dr_booking/',
        chooserTitle: 'HoJayega');
  }

  logout(context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Confirm Sign Out"),
            content: const Text("Are you sure to log out?"),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: colors.primary),
                child: Text("YES"),
                onPressed: () async {
                  removeSession();
                  Navigator.pop(context);
                  // SystemNavigator.pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: colors.primary),
                child: const Text("NO"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Future<void> removeSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("user_id");
  }

  void _handleNavigationChange(int index) {
    setState(() {
      selectedIndex = index;
    });
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => BottomNavBar(
                  dIndex: selectedIndex,
                )));

    // _child = AnimatedSwitcher(
    //   switchInCurve: Curves.bounceOut,
    //   switchOutCurve: Curves.bounceIn,
    //   duration: Duration(milliseconds: 100),
    //   child: _child,
    // );
  }
}

class DrawerIconTab extends StatefulWidget {
  final IconData? icon;
  final String? titlee;
  final int? tabb;
  final int? indexx;

  DrawerIconTab({Key? key, this.icon, this.titlee, this.tabb, this.indexx})
      : super(key: key);

  @override
  State<DrawerIconTab> createState() => _DrawerIconTabState();
}

class _DrawerIconTabState extends State<DrawerIconTab> {
  var Select = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
          gradient: widget.indexx == widget.tabb
              ? LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xff112C48), Color(0xff112C48)])
              : null),
      // color:
      //     widget.indexx == widget.tabb ? colors.secondary : Colors.transparent,
      child: Row(
        children: [
          SizedBox(
            width: 13,
          ),
          Container(
            decoration:
                BoxDecoration(color: Color(0xff112C48), shape: BoxShape.circle),
            height: 40,
            width: 40,
            child: Center(
                child: Icon(
              widget.icon,
              color: widget.indexx == widget.tabb ? Colors.white : Colors.grey,
              size: 20,
            )),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            '${widget.titlee}',
            style: TextStyle(
                fontSize: 15,
                fontWeight: widget.indexx == widget.tabb
                    ? FontWeight.bold
                    : FontWeight.normal,
                color: widget.indexx == widget.tabb
                    ? Colors.white
                    : Color(0xff112C48)),
          ),
        ],
      ),
    );
  }
}

// class DrawerImageTab extends StatefulWidget {
//   final String? titlee;
//   final String? img;
//   final int? tabb;
//   final int? indexx;
//   DrawerImageTab({Key? key, this.titlee, this.img, this.tabb, this.indexx})
//       : super(key: key);

//   @override
//   State<DrawerImageTab> createState() => _DrawerImageTabState();
// }

// class _DrawerImageTabState extends State<DrawerImageTab> {
//   var Select = 0;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: 50,
//       color:
//           widget.indexx == widget.tabb ? colors.secondary : Colors.transparent,
//       child: Row(
//         children: [
//           SizedBox(
//             width: 15,
//           ),
//           Container(
//             height: 25,
//             width: 25,
//             decoration: BoxDecoration(
//                 image: DecorationImage(
//                     image: AssetImage('${widget.img}'), fit: BoxFit.fill)),
//           ),
//           SizedBox(
//             width: 20,
//           ),
//           Text(
//             '${widget.titlee}',
//             style: TextStyle(
//                 fontSize: 15,
//                 fontWeight: widget.indexx == widget.tabb
//                     ? FontWeight.bold
//                     : FontWeight.normal,
//                 color: Colors.black),
//           ),
//         ],
//       ),
//     );
//   }
// }
