class College {
  final String collegeId;
  final String collegeName;

  College({
    required this.collegeId,
    required this.collegeName,
  });

  // Factory method to create a College instance from JSON
  factory College.fromJson(Map<String, dynamic> json) {
    return College(
      collegeId: json['college_id'],
      collegeName: json['college_name'],
    );
  }

  // Method to convert a College instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'college_id': collegeId,
      'college_name': collegeName,
    };
  }
}
