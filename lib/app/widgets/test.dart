import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> with WidgetsBindingObserver{
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(">>>>>>>>>>>>>>>>jks"+state.toString());
    if (state == AppLifecycleState.paused) {
      print(">>>>>>>>>>>>>>>>jks"+state.toString());

    } else {

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
