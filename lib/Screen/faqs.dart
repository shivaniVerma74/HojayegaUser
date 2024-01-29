import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ho_jayega_user_main/Helper/api.path.dart';
import 'package:http/http.dart' as http;
import '../Helper/color.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {


  void initState() {
    // TODO: implement initState
    super.initState();
   
  }
  



  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
          child:Scaffold(
            // key: _key,
              appBar: AppBar(
                backgroundColor:const Color(0xff112C48),
                title: const Text(
                  "Faqs",
                  style: TextStyle(color: Colors.white),
                ),
                centerTitle: true,
                toolbarHeight: 70,
                elevation: 6,
              ),
              body:
              SingleChildScrollView(
                child: Column(children: [

                  SizedBox(height: 20,),

                  Row(
                    children: [
                      SizedBox(width: 20,),
                      Text("FAQ",style: TextStyle(fontWeight: FontWeight.w500,color: colors.primary,fontSize: 17),),
                    ],
                  ),

                  Column(
                      children: [


                        // !isLoading?
                        Container(
                          padding: EdgeInsets.all(15),
                          height: MediaQuery.of(context).size.height/1.2,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8,),
                                child: faqTileDetails(
                                    question: "What Is Your Name", answer: 'My name id sura', index: index+1),
                              );
                            },
                            itemCount: 50,
                          ),
                        )
                        //     :
                        //
                        //
                        // Container(
                        //     height: MediaQuery.of(context).size.height/2,
                        //     child: Center(child: LoadingWidget2(context))),

                      ]
                  )



                ],),
              )
          )
      );
  }


  int selected = -1;
  Widget faqTileDetails(
      {required String question, required String answer, required int index}) {
    return

      Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),),
            elevation: 1,
            child: Container(
              decoration: BoxDecoration(borderRadius:BorderRadius.circular(10),

                  color: colors.whiteTemp
              ),
              child: ListTile(
                onTap: () {
                  setState(() {
                    if (selected == index) {
                      selected = -1;
                    } else {
                      selected = index;
                    }
                  });
                },
                title: Text(
                  question,
                  style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: colors.appbarColor
                  ),
                ),
                trailing: Icon(selected == index
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down),
              ),
            ),
          ),
          selected == index
              ? Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(horizontal: 5),
              color: colors.secondary,
              child: Html(data: answer,)
          )
              : Container(),
        ],
      );
  }
}
