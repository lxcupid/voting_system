import 'package:flutter/material.dart';

class SelectedCandidateModel {
  int presidentId;
  int vicePresidentId;
  int secretaryId;
  int treasurerId;
  int dataprivacyId;
  int itrepresentativeId;
  int isrepresentativeId;

  SelectedCandidateModel({
    this.presidentId = 0,
    this.vicePresidentId = 0,
    this.secretaryId = 0,
    this.treasurerId = 0,
    this.dataprivacyId = 0,
    this.itrepresentativeId = 0,
    this.isrepresentativeId = 0,
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
      presidentId: json['president_id'] ?? 0,
      vicePresidentId: json['vice_president_id'] ?? 0,
      secretaryId: json['secretary_id'] ?? 0,
      treasurerId: json['treasurer_id'] ?? 0,
      dataprivacyId: json['dataprivacy_id'] ?? 0,
      itrepresentativeId: json['it_representative_id'] ?? 0,
      isrepresentativeId: json['is_representative_id'] ?? 0,
    );
  }
}

class SelectedCandidateProvider with ChangeNotifier {
  SelectedCandidateModel _elected = SelectedCandidateModel();

  SelectedCandidateModel get elected => _elected;

  // Set President ID
  void setPresidentID(int id) {
    _elected.presidentId = id;
    notifyListeners();
  }

  // Set Vice President ID
  void setVicepresidentID(int id) {
    _elected.vicePresidentId = id;
    notifyListeners();
  }

  // Set Secretary ID
  void setSecretaryID(int id) {
    _elected.secretaryId = id;
    notifyListeners();
  }

  // Set Treasurer ID
  void setTreasurerID(int id) {
    _elected.treasurerId = id;
    notifyListeners();
  }

  // Set Data Privacy Officer ID
  void setDataprivacyID(int id) {
    _elected.dataprivacyId = id;
    notifyListeners();
  }

  // Set IT Representative ID
  void setITRepresentativeID(int id) {
    _elected.itrepresentativeId = id;
    notifyListeners();
  }

  // Set IS Representative ID
  void setISRepresentativeID(int id) {
    _elected.isrepresentativeId = id;
    notifyListeners();
  }

  // Reset all selections
  void resetSelections() {
    _elected = SelectedCandidateModel();
    notifyListeners();
  }
}
