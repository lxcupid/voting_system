class Candidate {
  final int candidateId;
  final String imageUrl; // URL or path for the candidate's image
  final String name;
  final String position;
  final String motto; // Motto of the candidate

  Candidate({
    required this.candidateId,
    required this.imageUrl,
    required this.name,
    required this.position,
    required this.motto,
  });
}

List<Candidate> candidates = [
  // President Candidates
  Candidate(
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/4/48/Outdoors-man-portrait_%28cropped%29.jpg',
    name: 'John Doe',
    motto:
        'Empowering Change for a Brighter Tomorrow: Together, we can build a future where every voice is heard and every dream is realized.',
    position: 'President',
    candidateId: 1554,
  ),

  // Vice President Candidates
  Candidate(
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fc/DrMLBrown_%28cropped%29.jpg/640px-DrMLBrown_%28cropped%29.jpg',
    name: 'Michael Brown',
    motto:
        'Innovation Through Unity: Together, we can revolutionize our future with new ideas and collaboration.',
    position: 'Vice President',
    candidateId: 5174788,
  ),

  // Secretary Candidates
  Candidate(
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/7/7f/Emma_Watson_2013.jpg',
    name: 'Emma Wilson',
    motto:
        'Transparency and Integrity: Together, we can create a trustworthy environment.',
    position: 'Secretary',
    candidateId: 664545,
  ),

  // Treasurer Candidates
  Candidate(
    imageUrl:
        'https://m.media-amazon.com/images/M/MV5BYWYwYzYzMjUtNWE0MS00NmJlLTljNGMtNzliYjg5NzQ1OWY5XkEyXkFqcGc@._V1_.jpg',
    name: 'Mason Taylor',
    motto:
        'Financial Stewardship for the Future: Together, we can ensure our resources are well managed.',
    position: 'Treasurer',
    candidateId: 64734,
  ),

  // Data Privacy Candidates
  Candidate(
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/a/a1/Ella_Purnell_Serpentine_Summer_Party_2017_%28cropped%29.jpg',
    name: 'Ella Roberts',
    motto:
        'Protecting Your Information: Together, we can safeguard our digital lives.',
    position: 'Data Privacy',
    candidateId: 654321,
  ),

  // IT Representative Candidates
  Candidate(
    imageUrl:
        'https://m.media-amazon.com/images/M/MV5BMjM1NTA0NDYzM15BMl5BanBnXkFtZTgwNzg5OTYyNjM@._V1_.jpg',
    name: 'Liam Hall',
    motto:
        'Empowering Change Through Technology: Together, we can embrace innovation for all.',
    position: 'IT Representative',
    candidateId: 234567,
  ),

  // IS Representative Candidates
  Candidate(
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ab/Emma_Watson_Circle_5.png/170px-Emma_Watson_Circle_5.png',
    name: 'Emma Harris',
    motto:
        'Connecting Ideas and Solutions: Together, we can bridge gaps in information systems.',
    position: 'IS Representative',
    candidateId: 345678,
  ),
];
