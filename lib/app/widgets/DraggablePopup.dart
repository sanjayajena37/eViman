import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

/*class DraggablePopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      maxChildSize: 1,
      minChildSize: 0.2,
      builder: (BuildContext context, ScrollController scrollController) {
        return
          Stack(children: [
          Container(
            height: 321,
            width: Get.width,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color(0xff16192C),
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 1,
                      blurRadius: 1,
                      color: Colors.grey.shade300)
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "There’s a new trip around you",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.location_searching_rounded,
                      size: 20,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Lagos-Abeokuta Expressway KM 748",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 9),
                  height: 8,
                  width: 2,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 2,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 9),
                  height: 8,
                  width: 2,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 2,
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.location_on,
                      size: 20,
                      color: Color(0xffADD685),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Queen Street 73",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 70,
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: const Icon(
                                    Icons.map,
                                    color:  Color(0xffA6B7D4),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "32Km",
                                  style: TextStyle(
                                      fontSize: 32,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Traveled distance",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 60,
                        width: 2,
                        color:  Color(0xffA6B7D4),
                      ),
                      SizedBox(
                        height: 70,
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Icon(
                                    Icons.person,
                                    color:  Color(0xffA6B7D4),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "12",
                                  style: TextStyle(
                                      fontSize: 32,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Passengers",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {

                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    decoration: BoxDecoration(
                        color: Color(0xff479100),
                        borderRadius: BorderRadius.circular(24)),
                    child: const Center(
                      child: Text(
                        "Accept ride",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              top: 10,
              right: 6,
              left: 266,
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.transparent),
                child: Align(
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ))
        ]);
      },
    );
  }
}*/

class DraggablePopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Draggable(
      child: Dialog(
        child:  Stack(children: [
          Container(
            height: 321,
            width: screenSize.width,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color(0xff16192C),
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 1,
                      blurRadius: 1,
                      color: Colors.grey.shade300)
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "There’s a new trip around you",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.location_searching_rounded,
                      size: 20,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Lagos-Abeokuta Expressway KM 748",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 9),
                  height: 8,
                  width: 2,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 2,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 9),
                  height: 8,
                  width: 2,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 2,
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.location_on,
                      size: 20,
                      color: Color(0xffADD685),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Queen Street 73",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 70,
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: const Icon(
                                    Icons.map,
                                    color:  Color(0xffA6B7D4),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "32Km",
                                  style: TextStyle(
                                      fontSize: 32,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Traveled distance",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 60,
                        width: 2,
                        color:  Color(0xffA6B7D4),
                      ),
                      SizedBox(
                        height: 70,
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Icon(
                                    Icons.person,
                                    color:  Color(0xffA6B7D4),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "12",
                                  style: TextStyle(
                                      fontSize: 32,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Passengers",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {

                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    decoration: BoxDecoration(
                        color: Color(0xff479100),
                        borderRadius: BorderRadius.circular(24)),
                    child: const Center(
                      child: Text(
                        "Accept ride",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              top: 10,
              right: 6,
              left: 266,
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.transparent),
                child: Align(
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ))
        ])
      ),
      feedback: Container(), // Empty container for the initial position
      childWhenDragging: Container(),
      // Empty container when dragging
    );
  }
}