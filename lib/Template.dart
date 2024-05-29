

import 'package:biiscorptes/ui/cart_page.dart';
import 'package:biiscorptes/ui/home.dart';
import 'package:biiscorptes/ui/user.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';


class Template extends StatefulWidget {
  const Template({super.key});

  @override
  State<Template> createState() => _TemplateState();
}

class _TemplateState extends State<Template> {
  int selectedPage = 0;
  final _pageOptions = [
     HomePage(),
     CartPage(),
     UserPage(),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOptions[selectedPage],
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.flip,
        color: Color.fromARGB(255, 136, 108, 108),
        activeColor: Color.fromARGB(255, 0, 0, 0),
        backgroundColor: Color.fromARGB(255, 95, 179, 212),
        elevation: 0,
        items: const [
          TabItem(icon: Icons.home_max_rounded, title: "Home"),
          TabItem(icon: Icons.shopping_cart_checkout_rounded, title: "Cart"),
          TabItem(icon: Icons.people_alt_rounded, title: "User"),
        ],
        initialActiveIndex: 0,
        onTap: (int i) {
          setState(() {
            selectedPage = i;
          });
        },
      ),
    );
  }
}
