import 'package:flutter/material.dart';

class AppNavBar extends StatelessWidget {
  /// currentIndex: 0=Home,1=Search,2=AddEvent,3=Calendar,4=Profile
  final int currentIndex;
  const AppNavBar({Key? key, required this.currentIndex}) : super(key: key);

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/main');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/search');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/add_event');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/calendar');
        break;
      case 4:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: (i) => _onTap(context, i),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.add_box), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: ''),
      ],
    );
  }
}
