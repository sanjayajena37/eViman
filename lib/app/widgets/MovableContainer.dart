import 'package:dateplan/app/widgets/tap_effect.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MovableContainer extends StatefulWidget {
  VoidCallback? onTap;

  MovableContainer({this.onTap});
  @override
  _MovableContainerState createState() => _MovableContainerState();
}

class _MovableContainerState extends State<MovableContainer> {
  Offset position = Offset(10, (Get.height/10)*6);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            position = Offset(
              position.dx + details.delta.dx,
              position.dy + details.delta.dy,
            );
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TapEffect(
                onClick: widget.onTap ?? () {},
                isClickable: true,
                child: Card(
                    elevation: 5,
                    color: Colors.deepPurpleAccent,
                    shape: CircleBorder(),
                    child:Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                          decoration:BoxDecoration (
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            border: Border.all(color: Colors.white,width: 2),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:  Text("Go",style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 30,color: Colors.white),),
                          )),
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
