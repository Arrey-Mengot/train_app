import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:train_app/authentication/auth.dart';
import 'package:train_app/pages/search_page.dart';

import 'home.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    int _selectedIndex = 0;
  void _onTap(int currentIndex){
    setState(() {
       _selectedIndex = currentIndex;
    });


  }
  @override
  Widget build(BuildContext context) {
    // _currentIndex = 0;
    return Scaffold(

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
          onTap: _onTap,
          elevation: 0.0,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home_filled, color: Colors.blueGrey,), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search_outlined, color: Colors.blueGrey,), label: 'Explore'),
            BottomNavigationBarItem(icon: Icon(Icons.airplane_ticket_outlined, color: Colors.blueGrey,), label: 'Ticket'),
            BottomNavigationBarItem(icon: Icon(Icons.person, color: Colors.blueGrey,), label: 'Profile')
          ]
      ),
      body: Center(
        child: IndexedStack(
          index: _selectedIndex,
          children: pages,
        )
      ),
    );
  }
}

List<Widget> pages = [
  const Home(),
  // const Text('Home', style: TextStyle(color: Colors.black),),
  const Center(child: SearchPage()),
  const Center(child: Text('Ticket')),
  Center(
    child: Consumer(
      builder: (context, ref, child) {
        return TextButton(onPressed: (){
          ref.read(authenticationProvider).signOut();
        }, child:const Text('Logout') );
      }
    ),
  ),
];

