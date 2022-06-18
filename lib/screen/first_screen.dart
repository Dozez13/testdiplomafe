import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:test_val/widget/form/login_form.dart';
import 'package:test_val/widget/form/registration_form.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: SafeArea(
            child: Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color.fromRGBO(95, 135, 161, 1.0),
              Color.fromRGBO(59, 110, 161, 1.0),
            ]),
      ),
      child: ContainedTabBarView(
        tabBarProperties: TabBarProperties(
          position: TabBarPosition.bottom,
          indicator: BoxDecoration(
              border: Border(
                  top: BorderSide(
                      color: Color.fromRGBO(140, 201, 238, 0.6),
                      width: 2.0,
                      style: BorderStyle.solid))),
          unselectedLabelColor: Color.fromRGBO(180, 174, 174, 1.0),
          labelColor: Colors.white,
          background: Container(
            color: Color.fromRGBO(255, 255, 255, 0.05),
          ),
        ),
        views: [
          CustomScrollView(slivers: [
            SliverFillRemaining(hasScrollBody: false, child: LoginForm())
          ]),
          CustomScrollView(slivers: [
            SliverFillRemaining(hasScrollBody: false, child: RegistrationForm())
          ]),
        ],
        tabs: [
          Text(
            "SIGN IN",
            style: TextStyle(fontSize: 20,fontFamily: "FiraCode",fontWeight: FontWeight.bold),
          ),
          Text(
            "SIGN UP",
            style: TextStyle(fontSize: 20,fontFamily: "FiraCode",fontWeight: FontWeight.bold),
          ),
        ],
      ),
    )));
  }
}
