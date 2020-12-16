import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//provider
import 'package:corona_virus/providers/home_provider.dart';

//pages
import 'package:corona_virus/screens/credit_screen.dart';
import 'package:corona_virus/screens/home_page.dart';
import 'package:corona_virus/screens/summery.dart';
import 'package:corona_virus/screens/loading_screen.dart';

//widgets
import 'package:corona_virus/widgets/navigation_bar.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  bool isLoading = false;
  bool homeDataLoded = false;

  @override
  void initState() {
    super.initState();
    if(homeDataLoded==false){
      initData();
    }
  }

  void initData() async {
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<HomeProvider>(context,listen: false).getData();
    }catch(e){
      showDialog(
        context: context,
        builder: (BuildContext ctx){
          return AlertDialog(
            title: Text(e.toString()),
          );
        }
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  int currentPageIndex = 0;
  List<Widget> pages = [HomePage(),CreditScreen(),Summery()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading ? LoadingScreen() : pages[currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onTap: (int i){
          setState(() {
            currentPageIndex=i;
          });
        },
        index: currentPageIndex
      )
    );
  }
}