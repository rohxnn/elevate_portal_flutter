
class BrandingModel {
  final String code;
  final String name;
  final String status;
  final String description;
  final String logo;
  final Map<String, dynamic> theming;

  BrandingModel({
    required this.code,
    required this.name,
    required this.status,
    required this.description,
    required this.logo,
    required this.theming,
  });

  factory BrandingModel.fromJson(Map<String, dynamic> json) {
    return BrandingModel(
      code: json['code'] ?? '',
      name: json['name'] ?? '',
      status: json['status'] ?? '',
      description: json['description'] ?? '',
      logo: json['logo'] ?? '',
      theming: json['theming'] ?? {},
    );
  }
}
