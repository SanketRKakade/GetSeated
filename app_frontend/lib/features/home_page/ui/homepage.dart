import 'package:app_frontend/features/authentication/ui/sign_in.dart';
import 'package:app_frontend/features/home_page/ui/seating.dart';
import 'package:app_frontend/features/home_page/ui/seminar_hall.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> widgetList = [SeatArrangement(), SeminarHall()];
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    // Navigate to the corresponding view based on index
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          leading: Icon(Icons.account_balance),
          title: Text("Get Seated"),
          actions: [
            IconButton(
              onPressed: () async {
                // Navigate to login page after successful sign out
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SignInPage()), // Replace with your login page widget
                );
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[Expanded(child: widgetList[_currentIndex])],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Image.asset("assets/logos/reading_hall_2.png"),
              label: 'Reading Hall',
            ),
            BottomNavigationBarItem(
              icon: Image.asset("assets/logos/seminar_hall_2.png"),
              label: 'Seminar Hall',
            ),
          ],
          currentIndex: _currentIndex,
          selectedItemColor: Theme.of(context).colorScheme.inversePrimary,
          onTap: _onItemTapped,
          // destinations: [
          //   NavigationDestination(
          //       icon: Image.asset("assets/logos/reading_hall.png"),
          //       label: "Reading Hall"),
          //   NavigationDestination(
          //       icon: Image.asset("assets/logos/seminar_hall.png"),
          //       label: "Seminar Hall")
          // ],
        ),
      ),
    );
  }
}
