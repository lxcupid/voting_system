class Candidate {
  final int candidateId;
  final String image; // Image as bytes (stored in the backend)
  final String name;
  final String position;
  final String college; // College of the candidate
  final String electionId; // Election ID for the candidate
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

// List<Candidate> candidates = [
//   // President Candidates
//   Candidate(
//     name: 'John Doe',
//     motto:
//         'Empowering Change for a Brighter Tomorrow: Together, we can build a future where every voice is heard and every dream is realized.',
//     position: 'President',
//     candidateId: 1554,
//     image: '',
//     college: 'CST01',
//     electionId: 1,
//   ),

//   // Vice President Candidates
//   Candidate(
//     name: 'Michael Brown',
//     motto:
//         'Innovation Through Unity: Together, we can revolutionize our future with new ideas and collaboration.',
//     position: 'Vice President',
//     candidateId: 5174788,
//     image: '',
//     college: 'CST01',
//     electionId: 1,
//   ),

//   // Secretary Candidates
//   Candidate(
//     image: '',
//     college: 'CST01',
//     electionId: 1,
//     name: 'Emma Wilson',
//     motto:
//         'Transparency and Integrity: Together, we can create a trustworthy environment.',
//     position: 'Secretary',
//     candidateId: 664545,
//   ),

//   // Treasurer Candidates
//   Candidate(
//     image: '',
//     college: 'CST01',
//     electionId: 1,
//     name: 'Mason Taylor',
//     motto:
//         'Financial Stewardship for the Future: Together, we can ensure our resources are well managed.',
//     position: 'Treasurer',
//     candidateId: 64734,
//   ),

//   // Data Privacy Candidates
//   Candidate(
//     image: '',
//     college: 'CST01',
//     electionId: 1,
//     name: 'Ella Roberts',
//     motto:
//         'Protecting Your Information: Together, we can safeguard our digital lives.',
//     position: 'Data Privacy',
//     candidateId: 654321,
//   ),

//   // IT Representative Candidates
//   Candidate(
//     image: '',
//     college: 'CST01',
//     electionId: 1,
//     name: 'Liam Hall',
//     motto:
//         'Empowering Change Through Technology: Together, we can embrace innovation for all.',
//     position: 'IT Representative',
//     candidateId: 234567,
//   ),

//   // IS Representative Candidates
//   Candidate(
//     image: '',
//     college: 'CST01',
//     electionId: 1,
//     name: 'Emma Harris',
//     motto:
//         'Connecting Ideas and Solutions: Together, we can bridge gaps in information systems.',
//     position: 'IS Representative',
//     candidateId: 345678,
//   ),
// ];
