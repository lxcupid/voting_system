class AdminCandidate1 {
  final String candidateId; // Updated to match JSON key
  final String fullname;
  final String position;
  final String motto;
  final String college;
  final String electionId;
  final int totalVotes; // New field to capture total votes
  final String image; // New field for the candidate's image

  AdminCandidate1({
    required this.candidateId,
    required this.fullname,
    required this.position,
    required this.motto,
    required this.college,
    required this.electionId,
    required this.totalVotes, // Include total votes in the constructor
    required this.image, // Include image in the constructor
  });

  factory AdminCandidate1.fromJson(Map<String, dynamic> json) {
    return AdminCandidate1(
      candidateId: json['candidate_id'],
      fullname: json['fullname'],
      position: json['position'],
      motto: json['motto'],
      college: json['college'],
      electionId: json['election_id'],
      totalVotes: json['total_votes'] ?? 0, // Handle null value with default
      image: json['image'] ?? '', // Handle null value with default for image
    );
  }
}
