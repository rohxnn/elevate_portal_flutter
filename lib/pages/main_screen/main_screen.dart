import 'package:elevate_portal_flutter/core/constants/app_colors.dart';
import 'package:elevate_portal_flutter/pages/home/home_screen.dart';
import 'package:elevate_portal_flutter/pages/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const HomeScreen(),
    const Center(child: Text('Downloads Page')),
    const Profile(),
  ];

  @override
  void initState() {
    super.initState();
    _loadSelectedIndex();
  }

  Future<void> _loadSelectedIndex() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedIndex = prefs.getInt('selectedIndex') ?? 0;
    });
  }

  Future<void> _saveSelectedIndex(int index) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('selectedIndex', index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
                _saveSelectedIndex(index);
              },
              selectedItemColor: AppColors.primary,
              unselectedItemColor: Colors.grey.shade400,
              selectedFontSize: 12,
              unselectedFontSize: 11,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: 'HOME'.tr(),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.download_sharp),
                  activeIcon: Icon(Icons.download_sharp),
                  label: 'DOWNLOADS'.tr(),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  activeIcon: Icon(Icons.person),
                  label: 'PROFILE'.tr(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
