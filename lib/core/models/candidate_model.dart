class Candidate {
  final int candidateId;
  final String image; // Image as bytes (stored in the backend)
  final String name;
  final String position;
  final String college; // College of the candidate
  final int electionId; // Election ID for the candidate
  final String motto; // Motto of the candidate (optional)

  Candidate({
    required this.candidateId,
    required this.image,
    required this.name,
    required this.position,
    required this.college,
    required this.electionId,
    this.motto = '',
  });

  // Factory constructor to create a Candidate object from JSON
  factory Candidate.fromJson(Map<String, dynamic> json) {
    return Candidate(
      candidateId: json['candidate_id'],
      image: json['image'], // Fetch image as bytes or a path/URL
      name: json['fullname'],
      position: json['position'],
      college: json['college'],
      electionId: json['election_id'],
      motto: json['motto'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'candidate_id': candidateId,
      'image': image,
      'fullname': name,
      'position': position,
      'college': college,
      'election_id': electionId,
      'motto': motto,
    };
  }
}
