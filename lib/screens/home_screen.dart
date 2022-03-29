import 'package:flutter/material.dart';
import 'package:flutter_getter/components/body.dart';
import 'package:flutter_getter/screens/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      body: Body(),
    );
  }
}
