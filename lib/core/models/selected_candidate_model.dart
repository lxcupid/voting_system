class SelectedCandidateModel {
  final int presidentId;
  final int vicePresidentId;
  final int secretaryId;
  final int treasurerId;
  final int dataprivacyId;
  final int itrepresentativeId;
  final int isrepresentativeId;

  SelectedCandidateModel({
    required this.presidentId,
    required this.vicePresidentId,
    required this.secretaryId,
    required this.treasurerId,
    required this.dataprivacyId,
    required this.itrepresentativeId,
    required this.isrepresentativeId,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'president_id': presidentId,
      'vice_president_id': vicePresidentId,
      'secretary_id': secretaryId,
      'treasurer_id': treasurerId,
      'dataprivacy_id': dataprivacyId,
      'it_representative_id': itrepresentativeId,
      'is_representative_id': isrepresentativeId,
    };
  }

  // Create an instance from JSON
  factory SelectedCandidateModel.fromJson(Map<String, dynamic> json) {
    return SelectedCandidateModel(
      presidentId: json['president_id'],
      vicePresidentId: json['vice_president_id'],
      secretaryId: json['secretary_id'],
      treasurerId: json['treasurer_id'],
      dataprivacyId: json['dataprivacy_id'],
      itrepresentativeId: json['it_representative_id'],
      isrepresentativeId: json['is_representative_id'],
    );
  }
}
