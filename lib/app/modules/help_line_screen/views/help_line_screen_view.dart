import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../Firebase/fireStoreDataModel.dart';
import '../../../widgets/common_appbar_view.dart';
import '../controllers/help_line_screen_controller.dart';

class HelpLineScreenView extends StatelessWidget {
   HelpLineScreenView({Key? key}) : super(key: key);

  HelpLineScreenController controller = Get.put<HelpLineScreenController>(HelpLineScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonAppbarView(
              iconData: Icons.arrow_back,
              titleText: "Help Line",
              onBackClick: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child:SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).padding.top,
                            left: 16,
                            right: 16),
                        child: Lottie.asset("assets/json/help_line.json",height: Get.height*0.3),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(
                            children: [
                              InkWell(
                                onTap: (){
                                  controller.makingPhoneCall("9124384030");
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 120,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        // color: Colors.purpleAccent,
                                        borderRadius: BorderRadius.circular(25.0),
                                        gradient: const LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Colors.pink,
                                            Colors.pinkAccent,



                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: -2, // Adjust slightly to cover the corner (optional)
                                      left: -2,  // Adjust slightly to cover the corner (optional)
                                      child: ClipOval( // Ensure circular shape
                                        child: Container(
                                          width: 70,
                                          height: 70,
                                          decoration: BoxDecoration(
                                            // color: Colors.cyan.withOpacity(0.4),
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(25.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Positioned(
                                      left: 45,
                                      bottom: 40,
                                      child: Column(
                                        children: [
                                          Icon(FontAwesomeIcons.phone,
                                            color: Colors.white,size: 30,),
                                          Text("Call",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),)
                                        ],
                                      ),)
                                  ],
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: (){
                              controller.sendWhatsappMessage();
                            },
                            child: Stack(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      width: 120,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        // color: Colors.purpleAccent,
                                        borderRadius: BorderRadius.circular(25.0),
                                        gradient: const LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Colors.green,
                                            Colors.tealAccent,

                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: -2, // Adjust slightly to cover the corner (optional)
                                      left: -2,  // Adjust slightly to cover the corner (optional)
                                      child: ClipOval( // Ensure circular shape
                                        child: Container(
                                          width: 70,
                                          height: 70,
                                          decoration: BoxDecoration(
                                            // color: Colors.cyan.withOpacity(0.4),
                                            color: Colors.green,
                                            borderRadius: BorderRadius.circular(25.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Positioned(
                                      left: 25,
                                      bottom: 30,
                                      child: Column(
                                        children: [
                                          Icon(FontAwesomeIcons.whatsapp,
                                            color: Colors.white,size: 50,),
                                          Text("Whats app",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),)
                                        ],
                                      ),)
                                  ],
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (){
                              controller.sendEmail();
                            },
                            child: Stack(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      width: 120,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        color: Colors.purpleAccent,
                                        borderRadius: BorderRadius.circular(25.0),
                                        gradient: const LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Colors.orange,
                                            Colors.redAccent,
                                            // Colors.orange,

                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: -2, // Adjust slightly to cover the corner (optional)
                                      left: -2,  // Adjust slightly to cover the corner (optional)
                                      child: ClipOval( // Ensure circular shape
                                        child: Container(
                                          width: 70,
                                          height: 70,
                                          decoration: BoxDecoration(
                                            // color: Colors.cyan.withOpacity(0.4),
                                            color: Colors.deepOrange,
                                            borderRadius: BorderRadius.circular(25.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Positioned(
                                      left: 35,
                                      bottom: 30,
                                      child: Column(
                                        children: [
                                          Icon(Icons.email_outlined,
                                            color: Colors.white,size: 50,),
                                          Text("Email",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),)
                                        ],
                                      ),)
                                  ],
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                    messagesListView()



                  ],
                ),
              ),
            ),
          ]),
    );
  }


   Widget messagesListView() {
     return SizedBox(
       height: Get.height * 0.80,
       width: Get.width,
       child: StreamBuilder(
         stream: controller.databaseService.getTodos(),
         builder: (context, snapshot) {
           List todos = snapshot.data?.docs ?? [];
           if (todos.isEmpty) {
             return InkWell(
               onTap: (){
                 controller.databaseService.addTodo(HelpCenter(name: "9124384030", email: "support@eviman.co.in"));
               },
               child: const Center(
                 child: Text("No Data Found"),
               ),
             );
           }
           return ListView.builder(
             itemCount: todos.length,
             itemBuilder: (context, index) {
               HelpCenter todo = todos[index].data();
               String todoId = todos[index].id;
               return Padding(
                 padding: const EdgeInsets.symmetric(
                   vertical: 10,
                   horizontal: 10,
                 ),
                 child: ListTile(
                   tileColor: Theme.of(context).colorScheme.primaryContainer,
                   title: Text(todo.name??""),
                   onLongPress: () {

                   },
                 ),
               );
             },
           );
         },
       ),
     );
   }


}
