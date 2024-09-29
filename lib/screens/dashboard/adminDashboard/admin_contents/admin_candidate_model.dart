class AdminCandidate {
  final String imageUrl;
  final String name;
  final String position;
  final int voteCount;

  AdminCandidate({required this.imageUrl, required this.name, required this.position, required this.voteCount});
}

List<AdminCandidate> adminCandidates = [
  AdminCandidate(
    imageUrl:
    'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Andrzej_Person_Kancelaria_Senatu.jpg/1200px-Andrzej_Person_Kancelaria_Senatu.jpg',
    name: 'John Doe',
    position: 'President',
    voteCount: 150
  ),
  AdminCandidate(
    imageUrl:
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQa4xjShh4ynJbrgYrW_aB4lhKSxeMzQ3cO_A&s',
    name: 'Jane Smith',
      position: 'President',
      voteCount: 150
  ),
  AdminCandidate(
    imageUrl:
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHr74Pjdj__bQPnZK-BFujbwgnP1t5PIqkig&s',
    name: 'Alice Johnson',
      position: 'Vice President',
      voteCount: 150
  ),
  AdminCandidate(
    imageUrl:
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQa4xjShh4ynJbrgYrW_aB4lhKSxeMzQ3cO_A&s',
    name: 'Patricia Moore',
      position: 'Vice President',
      voteCount: 150
  ),
  AdminCandidate(
      imageUrl:
      'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Andrzej_Person_Kancelaria_Senatu.jpg/1200px-Andrzej_Person_Kancelaria_Senatu.jpg',
      name: 'John Doe',
      position: 'Treasurer',
      voteCount: 150
  ),
  AdminCandidate(
      imageUrl:
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQa4xjShh4ynJbrgYrW_aB4lhKSxeMzQ3cO_A&s',
      name: 'Jane Smith',
      position: 'Treasurer',
      voteCount: 150
  ),
  AdminCandidate(
      imageUrl:
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHr74Pjdj__bQPnZK-BFujbwgnP1t5PIqkig&s',
      name: 'Alice Johnson',
      position: 'Secretary',
      voteCount: 150
  ),
  AdminCandidate(
      imageUrl:
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQa4xjShh4ynJbrgYrW_aB4lhKSxeMzQ3cO_A&s',
      name: 'Patricia Moore',
      position: 'Secretary',
      voteCount: 150
  ),
];