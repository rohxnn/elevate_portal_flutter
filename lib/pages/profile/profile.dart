import 'package:elevate_portal_flutter/data/services/user_service.dart';
import 'package:elevate_portal_flutter/pages/widgets/top_bar/top_bar.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
   final UserService _userService = UserService();
  List<Map<String, dynamic>> profileData = [];

  @override
 void initState() {
  super.initState();
  fetchReadHomeList();
 }

  fetchReadHomeList() async {
    final profileList = await _userService.readProfileData();
    if (profileList != null && profileList['result'] != null) {
      List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(profileList['result']);
      setState(() {
        profileData = data;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      appBar: TopBar(title: 'Profile'),  
      body: Center(child: Text('Profile content')),  
    );
  }
}