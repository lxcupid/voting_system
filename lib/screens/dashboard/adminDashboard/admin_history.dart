import 'package:flutter/material.dart';

class AdminHistory extends StatefulWidget {
  const AdminHistory({super.key});

  @override
  State<AdminHistory> createState() => _AdminHistoryState();
}

class _AdminHistoryState extends State<AdminHistory> {
  String? selectedItem = 'CCST'; // Default selected item

  // Mapping of collages to elections and their corresponding names
  final Map<String, List<Map<String, dynamic>>> collageMap = {
    'CCST': [
      {
        'title': 'Election 2020 - CCST',
        'names': [
          'Alice',
          'Bob',
          'Charlie',
          'Daisy',
          'Ethan',
          'Frank',
          'Grace',
          'Hannah'
        ]
      },
      {
        'title': 'Election 2021 - CCST',
        'names': [
          'Isaac',
          'Jack',
          'Kara',
          'Leo',
          'Mia',
          'Nate',
          'Olivia',
          'Paul'
        ]
      },
    ],
    'COE': [
      {
        'title': 'Election 2022 - COE',
        'names': ['Nad', 'Rose', 'Sam', 'Tina', 'Uma', 'Vera', 'Will', 'Xena']
      },
      {
        'title': 'Election 2023 - COE',
        'names': [
          'Yara',
          'Zane',
          'Amy',
          'Brad',
          'Cathy',
          'David',
          'Ella',
          'Fay'
        ]
      },
    ],
    'COA': [
      {
        'title': 'Election 2024 - COA',
        'names': [
          'Gina',
          'Hank',
          'Irene',
          'Jake',
          'Liam',
          'Maya',
          'Nora',
          'Oscar'
        ]
      },
      {
        'title': 'Election 2025 - COA',
        'names': [
          'Penny',
          'Quincy',
          'Rita',
          'Steve',
          'Tina',
          'Ursula',
          'Vince',
          'Will'
        ]
      },
    ],
    'CAS': [
      {
        'title': 'Election 2026 - CAS',
        'names': [
          'Xena',
          'Yuri',
          'Zara',
          'Aaron',
          'Bella',
          'Carter',
          'Diana',
          'Eli'
        ]
      },
      {
        'title': 'Election 2027 - CAS',
        'names': [
          'Fiona',
          'Gabe',
          'Holly',
          'Ian',
          'Jade',
          'Kyle',
          'Lila',
          'Mike'
        ]
      },
    ],
    'CTE': [
      {
        'title': 'Election 2028 - CTE',
        'names': [
          'Nina',
          'Owen',
          'Piper',
          'Quin',
          'Ray',
          'Sophie',
          'Toby',
          'Uma'
        ]
      },
      {
        'title': 'Election 2029 - CTE',
        'names': [
          'Vera',
          'Will',
          'Xena',
          'Yara',
          'Zane',
          'Alex',
          'Becky',
          'Clara'
        ]
      },
    ],
    'CTHM': [
      {
        'title': 'Election 2030 - CTHM',
        'names': [
          'John',
          'Sarah',
          'Michael',
          'Jessica',
          'David',
          'Laura',
          'James',
          'Linda'
        ]
      },
      {
        'title': 'Election 2031 - CTHM',
        'names': [
          'Robert',
          'Emily',
          'Daniel',
          'Sophia',
          'Thomas',
          'Isabella',
          'Matthew',
          'Emma'
        ]
      },
    ],
    'CAHS': [
      {
        'title': 'Election 2032 - CAHS',
        'names': [
          'Ethan',
          'Ava',
          'Oliver',
          'Mia',
          'Lucas',
          'Charlotte',
          'Henry',
          'Amelia'
        ]
      },
      {
        'title': 'Election 2033 - CAHS',
        'names': [
          'Jack',
          'Harper',
          'Liam',
          'Ella',
          'Noah',
          'Sofia',
          'Jacob',
          'Grace'
        ]
      },
    ],
    'CBA': [
      {
        'title': 'Election 2034 - CBA',
        'names': [
          'Charlotte',
          'Matthew',
          'David',
          'Evelyn',
          'Liam',
          'Ella',
          'Isaac',
          'Sofia'
        ]
      },
      {
        'title': 'Election 2035 - CBA',
        'names': [
          'James',
          'Amelia',
          'Alexander',
          'Harper',
          'Henry',
          'Scarlett',
          'Michael',
          'Victoria'
        ]
      },
    ],
    'CHK': [
      {
        'title': 'Election 2037 - CHK',
        'names': [
          'Daniel',
          'Chloe',
          'Jackson',
          'Grace',
          'Matthew',
          'Aria',
          'Gabriel',
          'Nora'
        ]
      },
      {
        'title': 'Election 2037 - CHK',
        'names': [
          'Daniel',
          'Chloe',
          'Jackson',
          'Grace',
          'Matthew',
          'Aria',
          'Gabriel',
          'Nora'
        ]
      },
      {
        'title': 'Election 2037 - CHK',
        'names': [
          'Daniel',
          'Chloe',
          'Jackson',
          'Grace',
          'Matthew',
          'Aria',
          'Gabriel',
          'Nora'
        ]
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    final List<String> collage = collageMap.keys.toList();
    List<Map<String, dynamic>> currentElections =
        collageMap[selectedItem] ?? [];
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 10),
                const Text(
                  'History of Elections',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 215, 215, 215),
                      borderRadius: BorderRadius.circular(15)),
                  child: DropdownButton<String>(
                    value: selectedItem,
                    onChanged: (newValue) {
                      setState(() {
                        selectedItem = newValue;
                      });
                    },
                    items: collage.map((item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(currentElections.length, (index) {
                final election = currentElections[index];
                final electionTitle = election['title'] as String?;
                final electionNames = election['names'] as List<String>;
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          electionTitle ?? '',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(height: 10),
                        TextRow(names: electionNames),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class TextRow extends StatelessWidget {
  final List<String> names;

  const TextRow({
    super.key,
    required this.names,
  });

  @override
  Widget build(BuildContext context) {
    List<String> positions = [
      'President',
      'Vice President',
      'Secretary',
      'Treasurer',
      'Auditor',
      'Data Privacy',
      'IT Representative',
      'IS Representative',
    ];
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(positions.length, (index) {
            // Ensure to not exceed the length of names
            if (index < names.length) {
              return Row(
                children: [
                  Text(
                    positions[index],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  SizedBox(width: 10),
                  Text(
                    names[index],
                    style: TextStyle(fontFamily: 'Arial', fontSize: 15),
                  ),
                ],
              );
            } else {
              return Container(); // Return empty container if no name available
            }
          }),
        ),
      ],
    );
  }
}
