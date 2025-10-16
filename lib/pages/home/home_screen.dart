import 'package:elevate_portal_flutter/data/services/user_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserService _userService = UserService();
  final List<Map<String, dynamic>> cardData = [];
  @override
  void initState() {
    super.initState();
    fetchReadHomeList();
  }


  fetchReadHomeList() async {
    final homeList = await _userService.readHomeListForm();
    print("Home List: $homeList");
    setState(() {
      for (var item in homeList['result']) {
        print(  "Item: $item");
        cardData.add(item);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: ListView.builder(
        itemCount: cardData.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(cardData[index]['feature_name']),
            ),
          );
        },
      ),
    );
  }
}
