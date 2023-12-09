import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final String imagePath;
  final String? title;
  final String ?photographer;
  final String ?price;
  final String ?details;
  final int index;
  DetailsPage(
      {required this.imagePath,
         this.title,
         this.photographer,
         this.price,
         this.details,
        required this.index});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height*0.7,
            child: Expanded(
              child: Hero(
                tag: 'logo$index',
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),topLeft:Radius.circular(30) ,topRight:Radius.circular(30) ),
                        image: DecorationImage(
                          image: NetworkImage(imagePath),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}