import 'package:easy_localization/easy_localization.dart';
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
  Map<String, dynamic>? profileData;

  @override
  void initState() {
    super.initState();
    fetchReadHomeList();
    fetchProfile();
  }

  fetchReadHomeList() async {
    final homeList = await _userService.readHomeListForm();
    if (homeList != null && homeList['result'] != null) {
      List<Map<String, dynamic>> features = List<Map<String, dynamic>>.from(
        homeList['result'],
      );
      features.sort(
        (a, b) =>
            (a['display_order'] ?? 0).compareTo(b['display_order'] ?? 0),
      );
      features = features.where((data) => data['enabled'] == true).toList();
      setState(() {
        cardData = features;
      });
    }
  }

  fetchProfile() async {
    final profileList = await _userService.readProfileData();
    if (profileList != null && profileList['result'] != null) {
      setState(() {
        profileData = profileList['result'] as Map<String, dynamic>;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userName =
        profileData?['name']?.toString().trim().isNotEmpty == true
            ? profileData!['name'].toString().trim()
            : 'Shikshagraha';
    final userImage = profileData?['image']?.toString() ?? '';
    final userInitial = userName.substring(0, 1).toUpperCase();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white,
                      backgroundImage: userImage.isNotEmpty
                          ? NetworkImage(userImage)
                          : null,
                      child: userImage.isEmpty
                          ? Text(
                              userInitial,
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'WELCOME_BACK'.tr(),
                          style: TextStyle(
                            color: Colors.black.withValues(alpha: 0.55),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          userName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(8, 16, 8, 12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1,
                ),
                itemCount: cardData.length,
                itemBuilder: (context, index) {
                  final feature = cardData[index];
                  return SizedBox.expand(
                    child: FeatureCard(feature: feature),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
