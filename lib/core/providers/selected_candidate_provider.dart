import 'package:flutter/material.dart';

class SelectedCandidateModel {
  int presidentId;
  int vicePresidentId;
  int secretaryId;

  SelectedCandidateModel({
    this.presidentId = 0,
    this.vicePresidentId = 0,
    this.secretaryId = 0,
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
      presidentId: json['president_id'] ?? 0,
      vicePresidentId: json['vice_president_id'] ?? 0,
      secretaryId: json['secretary_id'] ?? 0,
    );
  }
}

class SelectedCandidateProvider with ChangeNotifier {
  SelectedCandidateModel _elected = SelectedCandidateModel();

  SelectedCandidateModel get elected => _elected;

  void setPresidentID(int id) {
    _elected.presidentId = id;
    notifyListeners();
  }

  void setVicepresidentID(int id) {
    _elected.vicePresidentId = id;
    notifyListeners();
  }

  void setSecretaryID(int id) {
    _elected.secretaryId = id;
    notifyListeners();
  }
}
