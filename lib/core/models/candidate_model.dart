class Candidate {
  final int candidateId;
  final String imageUrl; // URL or path for the candidate's image
  final String name;
  final String position;
  final String motto; // Motto of the candidate

  Candidate(
      {required this.candidateId,
      required this.imageUrl,
      required this.name,
      required this.position,
      required this.motto});
}

List<Candidate> candidates = [
  Candidate(
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Andrzej_Person_Kancelaria_Senatu.jpg/1200px-Andrzej_Person_Kancelaria_Senatu.jpg',
    name: 'John Doe',
    motto:
        'Empowering Change for a Brighter Tomorrow: Together, we can build a future where every voice is heard and every dream is realized.',
    position: 'President',
    candidateId: 1554,
  ),
  Candidate(
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQa4xjShh4ynJbrgYrW_aB4lhKSxeMzQ3cO_A&s',
    name: 'Jane Smith',
    motto:
        'Together We Rise, Together We Thrive: By uniting our strengths and embracing our differences, we can create a community where everyone has the opportunity to succeed.',
    position: 'President',
    candidateId: 54154,
  ),
  Candidate(
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHr74Pjdj__bQPnZK-BFujbwgnP1t5PIqkig&s',
    name: 'Alice Johnson',
    motto:
        'Your Voice, Our Future: Join us in shaping a tomorrow that reflects our shared values and aspirations, where everyone plays a vital role in the journey ahead.',
    position: 'Vice President',
    candidateId: 514521,
  ),
  Candidate(
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Andrzej_Person_Kancelaria_Senatu.jpg/1200px-Andrzej_Person_Kancelaria_Senatu.jpg',
    name: 'John Doe',
    motto:
        'Empowering Change for a Brighter Tomorrow: Together, we can build a future where every voice is heard and every dream is realized.',
    position: 'Vice President',
    candidateId: 5174788,
  ),
  Candidate(
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHr74Pjdj__bQPnZK-BFujbwgnP1t5PIqkig&s',
    name: 'Alice Johnson',
    motto:
        'Your Voice, Our Future: Join us in shaping a tomorrow that reflects our shared values and aspirations, where everyone plays a vital role in the journey ahead.',
    position: 'Secretary',
    candidateId: 47517,
  ),
  Candidate(
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Andrzej_Person_Kancelaria_Senatu.jpg/1200px-Andrzej_Person_Kancelaria_Senatu.jpg',
    name: 'John Doe',
    motto:
        'Empowering Change for a Brighter Tomorrow: Together, we can build a future where every voice is heard and every dream is realized.',
    position: 'Secretary',
    candidateId: 547854,
  ),
];
