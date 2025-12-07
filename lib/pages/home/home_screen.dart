import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_portal_flutter/core/config/env.dart';
import 'package:elevate_portal_flutter/core/constants/app_colors.dart';
import 'package:elevate_portal_flutter/data/services/user_service.dart';
import 'package:elevate_portal_flutter/pages/home/widgets/feature_card.dart';
import 'package:elevate_portal_flutter/pages/widgets/top_bar/top_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserService _userService = UserService();
  List<Map<String, dynamic>> cardData = [];
  @override
  void initState() {
    super.initState();
    fetchReadHomeList();
  }


  fetchReadHomeList() async {
    final homeList = await _userService.readHomeListForm();
    if (homeList != null && homeList['result'] != null) {
      List<Map<String, dynamic>> features = List<Map<String, dynamic>>.from(homeList['result']);
      features.sort((a, b) => (a['display_order'] ?? 0).compareTo(b['display_order'] ?? 0));
      features = features.where((data) => data['enabled'] == true).toList();
      setState(() {
        cardData = features;
      });
    }
  }


  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: TopBar(title: 'HOME'.tr()),
    body: GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 tiles per row
        crossAxisSpacing: 8.0, // horizontal spacing between tiles
        mainAxisSpacing: 8.0, // vertical spacing between tiles
        childAspectRatio: 1.0, // adjust for tile height
      ),
      itemCount: cardData.length,
      itemBuilder: (context, index) {
        final feature = cardData[index];
        return SizedBox.expand(
          child: FeatureCard(feature: feature),
        );
      },
    ),
  );
}
}
