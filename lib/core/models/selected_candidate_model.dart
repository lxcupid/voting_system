class SelectedCandidateModel {
  final int presidentId;
  final int vicePresidentId;
  final int secretaryId;

  SelectedCandidateModel({
    required this.presidentId,
    required this.vicePresidentId,
    required this.secretaryId,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'president_id': presidentId,
      'vice_president_id': vicePresidentId,
      'secretary_id': secretaryId,
    };
  }

  // Create an instance from JSON
  factory SelectedCandidateModel.fromJson(Map<String, dynamic> json) {
    return SelectedCandidateModel(
      presidentId: json['president_id'],
      vicePresidentId: json['vice_president_id'],
      secretaryId: json['secretary_id'],
    );
  }
}
