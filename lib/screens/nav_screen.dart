import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_netflix_ui/cubits/app_bar/app_bar_cubit.dart';
import 'package:flutter_netflix_ui/screens/home_screen.dart';
import 'package:flutter_netflix_ui/widgets/responsive.dart';

class NavScreen extends StatefulWidget {
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final List<Widget> _screen = [
    HomeScreen(key: PageStorageKey('HomeScreen')),
    Placeholder(),
    Placeholder(),
    Placeholder(),
    Placeholder(),
  ];
  int _currentIndex = 0;

  final Map<String, IconData> _icons = const {
    'Home': Icons.home,
    'Search': Icons.search,
    'Coming Soon': Icons.queue_play_next,
    'Downloads': Icons.file_download,
    'More': Icons.menu
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AppBarCubit>(
        create: (_) => AppBarCubit(),
        child: _screen[_currentIndex],
      ),
      bottomNavigationBar: !Responsive.isDesktop(context)
          ? BottomNavigationBar(
              backgroundColor: Colors.black,
              items: _icons
                  .map(
                    (title, icon) => MapEntry(
                      title,
                      BottomNavigationBarItem(
                        title: Text(title),
                        icon: Icon(
                          icon,
                          size: 30,
                        ),
                      ),
                    ),
                  )
                  .values
                  .toList(),
              currentIndex: _currentIndex,
              selectedItemColor: Colors.white,
              selectedFontSize: 11.0,
              unselectedItemColor: Colors.grey,
              onTap: (value) => setState(() => _currentIndex = value),
            )
          : null,
    );
  }
}
