import 'package:elevate_portal_flutter/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class FeatureCard extends StatelessWidget {
  final Map feature;

  const FeatureCard({super.key, required this.feature});

  @override
  Widget build(BuildContext context) {
    final meta = feature['meta'] as Map?;
    final title = meta?['title'] as String? ??
        feature['feature_name'] as String? ??
        'Unnamed Feature';
    final iconUrl = meta?['icon'] as String?;
    final theme = meta?['theme'] as Map?;
    final primaryColorString = theme?['primaryColor'] as String?;
    final primaryColor = primaryColorString != null
        ? Color(int.parse(primaryColorString.substring(1, 7), radix: 16) +
            0xFF000000)
        : AppColors.primary;

    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60.0,
                height: 60.0,
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: iconUrl != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.network(
                          iconUrl,
                          width: 60.0,
                          height: 60.0,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.apps,
                              size: 32.0,
                              color: primaryColor,
                            );
                          },
                        ),
                      )
                    : Icon(
                        Icons.apps,
                        size: 32.0,
                        color: primaryColor,
                      ),
              ),
              const SizedBox(height: 12.0),
              Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}