
import 'package:elevate_portal_flutter/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class FeatureCard extends StatelessWidget {
  final Map<String, dynamic> feature;

  const FeatureCard({super.key, required this.feature});

  @override
  Widget build(BuildContext context) {
    final meta = feature['meta'] as Map<String, dynamic>?;
    final title = meta?['title'] as String? ?? feature['feature_name'] as String? ?? 'Unnamed Feature';
    final iconUrl = meta?['icon'] as String?;
    final theme = meta?['theme'] as Map<String, dynamic>?;
    final primaryColorString = theme?['primaryColor'] as String?;
    final primaryColor = primaryColorString != null
        ? Color(int.parse(primaryColorString.substring(1, 7), radix: 16) + 0xFF000000)
        : AppColors.primary;

    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        onTap: () {
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              if (iconUrl != null)
                Image.network(
                  iconUrl,
                  width: 40.0,
                  height: 40.0,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.apps, size: 40.0, color: primaryColor);
                  },
                ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.grey.shade600),
            ],
          ),
        ),
      ),
    );
  }
}
