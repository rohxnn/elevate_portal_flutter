import 'package:elevate_portal_flutter/core/config/env.dart';
import 'package:elevate_portal_flutter/core/constants/app_colors.dart';
import 'package:elevate_portal_flutter/data/services/user_service.dart';
import 'package:elevate_portal_flutter/pages/home/widgets/feature_card.dart';
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
      setState(() {
        cardData = features;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
            
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: Colors.grey.shade200,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: cardData.length,
        itemBuilder: (context, index) {
          final feature = cardData[index];
          final meta = feature['meta'];
          if (meta != null && meta['icon'] != null) {
            meta['icon'] = '${Env.publicBaseUrl}${meta['icon']}';
          }
          return FeatureCard(feature: feature);
        },
      ),
    );
  }
}
