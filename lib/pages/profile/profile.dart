import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_portal_flutter/core/widgets/confirmation_dialog/confirmation_dialog.dart';
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
  Map<String, dynamic>? profileData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchReadHomeList();
  }

  fetchReadHomeList() async {
    final profileList = await _userService.readProfileData();
    if (profileList != null && profileList['result'] != null) {
      setState(() {
        profileData = profileList['result'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showResetPasswordDialog() {
    ConfirmationDialog.show(
      context: context,
      title: 'Reset Password',
      content: 'Are you sure you want to reset your password? You will receive a password reset link via email.',
      confirmText: 'Reset',
      cancelText: 'Cancel',
      icon: Icons.lock_reset,
      isDangerous: false,
      onConfirm: () {},
    );
  }

  void _showDeleteAccountDialog() {
    ConfirmationDialog.show(
      context: context,
      title: 'Delete Account',
      content:
          'Are you sure you want to delete your account? This action cannot be undone.',
      confirmText: 'Delete',
      cancelText: 'Cancel',
      icon: Icons.delete_forever,
      isDangerous: true,
      onConfirm: () {},
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(title: 'PROFILE'.tr()),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).primaryColor.withOpacity(0.7),
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.white,
                            backgroundImage: profileData?['image'] != null &&
                                    profileData!['image'].toString().isNotEmpty
                                ? NetworkImage(profileData!['image'])
                                : null,
                            child: profileData?['image'] == null ||
                                    profileData!['image']
                                        .toString()
                                        .isEmpty
                                ? Text(
                                    profileData?['name']
                                            ?.toString()
                                            .substring(0, 1)
                                            .toUpperCase() ??
                                        'U',
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  )
                                : null,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Name
                        Text(
                          profileData?['name']?.toString() ?? 'User Name',
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Email
                        Text(
                          profileData?['email']?.toString() ??
                              'user@example.com',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),

                  // Profile Details Cards
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOCATION_DETAILS'.tr(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Location Information Card
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                _buildInfoRow(
                                  icon: Icons.location_city,
                                  label: 'State',
                                  value: profileData?['state']?['label']
                                          ?.toString() ??
                                      'Not available',
                                ),
                                const Divider(height: 24),
                                _buildInfoRow(
                                  icon: Icons.map,
                                  label: 'District',
                                  value: profileData?['district']?['label']
                                          ?.toString() ??
                                      'Not available',
                                ),
                                const Divider(height: 24),
                                _buildInfoRow(
                                  icon: Icons.location_on,
                                  label: 'Block',
                                  value: profileData?['block']?['label']
                                          ?.toString() ??
                                      'Not available',
                                ),
                                const Divider(height: 24),
                                _buildInfoRow(
                                  icon: Icons.hub,
                                  label: 'Cluster',
                                  value: profileData?['cluster']?['label']
                                          ?.toString() ??
                                      'Not available',
                                ),
                                const Divider(height: 24),
                                _buildInfoRow(
                                  icon: Icons.school,
                                  label: 'School',
                                  value: profileData?['school']?['label']
                                          ?.toString() ??
                                      'Not available',
                                ),
                                const Divider(height: 24),
                                _buildInfoRow(
                                  icon: Icons.work,
                                  label: 'Professional Role',
                                  value: profileData?['professional_role']
                                          ?['label']
                                          ?.toString() ??
                                      'Not available',
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Language Settings
                        Text(
                          'LANGUAGE_SETTING'.tr(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ChoiceChip(
                                label: const Text('English'),
                                selected: context.locale.languageCode == 'en',
                                onSelected: (_) {
                                  context.setLocale(const Locale('en'));
                                },
                              ),
                              ChoiceChip(
                                label: const Text('हिंदी'),
                                selected: context.locale.languageCode == 'hi',
                                onSelected: (_) {
                                  context.setLocale(const Locale('hi'));
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                        const SizedBox(height: 32),

                        // Action Buttons
                        Text(
                          'ACCOUNT_SETTING'.tr(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Reset Password Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: _showResetPasswordDialog,
                            icon: const Icon(Icons.lock_reset),
                            label:  Text('RESET_PASSWORD'.tr()),
                            style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Delete Account Button
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: _showDeleteAccountDialog,
                            icon: const Icon(Icons.delete_forever,
                                color: Colors.red),
                            label: Text(
                              'DELETE_ACCOUNT'.tr(),
                              style: TextStyle(color: Colors.red),
                            ),
                            style: OutlinedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16),
                              side: const BorderSide(color: Colors.red),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Theme.of(context).primaryColor,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
