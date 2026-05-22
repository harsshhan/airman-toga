class CadetProfile {
  final String name;
  final String role;
  final String course;
  final String fto;
  final String instructor;
  final String base;

  const CadetProfile({
    required this.name,
    required this.role,
    required this.course,
    required this.fto,
    required this.instructor,
    required this.base,
  });

  factory CadetProfile.fromJson(Map<String, dynamic> json) {
    return CadetProfile(
      name: json['name'] ?? '',
      role: json['role'] ?? '',
      course: json['course'] ?? '',
      fto: json['fto'] ?? '',
      instructor: json['instructor'] ?? '',
      base: json['base'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'role': role,
      'course': course,
      'fto': fto,
      'instructor': instructor,
      'base': base,
    };
  }
}