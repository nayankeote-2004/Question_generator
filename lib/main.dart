import 'package:flutter/material.dart';
import 'package:test_1/generate_screen.dart';
import 'package:test_1/login.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'College App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AuthPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedBranch;
  String? selectedYear;
  String? selectedSemester;
  String? selectedSubject;
  String? selectedExamination;

  final Map<String, Map<String, Map<String, List<String>>>> branches = {
    'Computer Science': {
      '1st Year': {
        'Semester 1': ['Mathematics 1', 'Programming 1', 'Digital Logic'],
        'Semester 2': ['Mathematics 2', 'Programming 2', 'Data Structures'],
      },
      '2nd Year': {
        'Semester 3': ['Algorithms', 'Operating Systems', 'Database Systems'],
        'Semester 4': [
          'Computer Networks',
          'Software Engineering',
          'Machine Learning'
        ],
      },
      '3rd Year': {
        'Semester 5': [
          'Artificial Intelligence',
          'Compiler Design',
          'Web Technologies'
        ],
        'Semester 6': ['Cryptography', 'Cloud Computing', 'Data Mining'],
      },
      '4th Year': {
        'Semester 7': ['Big Data', 'Internet of Things', 'Cybersecurity'],
        'Semester 8': [
          'Blockchain Technology',
          'Quantum Computing',
          'Final Year Project'
        ],
      },
    },
    'Mechanical': {
      '1st Year': {
        'Semester 1': [
          'Engineering Mathematics',
          'Engineering Mechanics',
          'Basic Thermodynamics'
        ],
        'Semester 2': [
          'Fluid Mechanics',
          'Manufacturing Processes',
          'Material Science'
        ],
      },
      '2nd Year': {
        'Semester 3': [
          'Strength of Materials',
          'Kinematics of Machines',
          'Thermodynamics'
        ],
        'Semester 4': [
          'Machine Design',
          'Heat Transfer',
          'Dynamics of Machines'
        ],
      },
      '3rd Year': {
        'Semester 5': [
          'Manufacturing Technology',
          'Control Engineering',
          'Mechanical Vibrations'
        ],
        'Semester 6': [
          'Automobile Engineering',
          'Power Plant Engineering',
          'Finite Element Analysis'
        ],
      },
      '4th Year': {
        'Semester 7': ['Robotics', 'Mechatronics', 'Renewable Energy Systems'],
        'Semester 8': [
          'Advanced Manufacturing',
          'Industrial Automation',
          'Final Year Project'
        ],
      },
    },
    'Civil': {
      '1st Year': {
        'Semester 1': [
          'Engineering Mathematics',
          'Engineering Drawing',
          'Building Materials'
        ],
        'Semester 2': ['Surveying', 'Strength of Materials', 'Fluid Mechanics'],
      },
      '2nd Year': {
        'Semester 3': [
          'Structural Analysis',
          'Concrete Technology',
          'Geotechnical Engineering'
        ],
        'Semester 4': [
          'Environmental Engineering',
          'Transportation Engineering',
          'Hydraulics'
        ],
      },
      '3rd Year': {
        'Semester 5': [
          'Structural Design',
          'Foundation Engineering',
          'Construction Technology'
        ],
        'Semester 6': [
          'Water Resource Engineering',
          'Prestressed Concrete',
          'Project Management'
        ],
      },
      '4th Year': {
        'Semester 7': [
          'Earthquake Engineering',
          'Advanced Structural Analysis',
          'Bridge Engineering'
        ],
        'Semester 8': [
          'Sustainable Construction',
          'Urban Planning',
          'Final Year Project'
        ],
      },
    },
    'EnTC': {
      '1st Year': {
        'Semester 1': [
          'Mathematics 1',
          'Circuit Analysis',
          'Digital Electronics'
        ],
        'Semester 2': ['Mathematics 2', 'Analog Circuits', 'Signal Processing'],
      },
      '2nd Year': {
        'Semester 3': [
          'Microprocessors',
          'Control Systems',
          'Electromagnetic Fields'
        ],
        'Semester 4': [
          'VLSI Design',
          'Communication Systems',
          'Embedded Systems'
        ],
      },
      '3rd Year': {
        'Semester 5': [
          'Antenna Design',
          'Wireless Communication',
          'Optical Fiber Communication'
        ],
        'Semester 6': [
          'Digital Signal Processing',
          'Satellite Communication',
          'Radar Engineering'
        ],
      },
      '4th Year': {
        'Semester 7': [
          'IoT Systems',
          'Network Security',
          'Robotics and Automation'
        ],
        'Semester 8': [
          'Advanced Communication Systems',
          'Artificial Intelligence',
          'Final Year Project'
        ],
      },
    },
    'IT': {
      '1st Year': {
        'Semester 1': ['Mathematics 1', 'Programming 1', 'Digital Logic'],
        'Semester 2': ['Mathematics 2', 'Programming 2', 'Data Structures'],
      },
      '2nd Year': {
        'Semester 3': [
          'Web Development',
          'Operating Systems',
          'Database Management'
        ],
        'Semester 4': [
          'Mobile App Development',
          'Software Engineering',
          'Computer Networks'
        ],
      },
      '3rd Year': {
        'Semester 5': [
          'Cloud Computing',
          'Machine Learning',
          'Information Security'
        ],
        'Semester 6': [
          'Data Science',
          'Blockchain Technology',
          'Artificial Intelligence'
        ],
      },
      '4th Year': {
        'Semester 7': ['Big Data', 'IoT', 'Cybersecurity'],
        'Semester 8': [
          'Quantum Computing',
          'Data Privacy',
          'Final Year Project'
        ],
      },
    },
  };

  final List<String> years = ['1st Year', '2nd Year', '3rd Year', '4th Year'];
  final List<String> examinations = [
    'Mid Term',
    'Final',
    'Backlog',
    'Supplementary'
  ];

  // Mock data for Excel files
  final List<Map<String, String>> excelFiles = [
    {'name': 'Question Paper.xlsx', 'path': 'assets/question_paper.xlsx'},
    {'name': 'Answer Key.xlsx', 'path': 'assets/answer_key.xlsx'},
    {'name': 'Results.xlsx', 'path': 'assets/results.xlsx'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            _buildDropdown(
                'Select Branch', selectedBranch, branches.keys.toList(),
                (value) {
              setState(() {
                selectedBranch = value;
                selectedYear = null;
                selectedSemester = null;
                selectedSubject = null;
              });
            }),
            if (selectedBranch != null) ...[
              _buildDropdown('Select Year', selectedYear, years, (value) {
                setState(() {
                  selectedYear = value;
                  selectedSemester = null;
                  selectedSubject = null;
                });
              }),
            ],
            if (selectedYear != null) ...[
              _buildDropdown('Select Semester', selectedSemester,
                  branches[selectedBranch]![selectedYear]!.keys.toList(),
                  (value) {
                setState(() {
                  selectedSemester = value;
                  selectedSubject = null;
                });
              }),
            ],
            if (selectedSemester != null) ...[
              _buildDropdown('Select Subject', selectedSubject,
                  branches[selectedBranch]![selectedYear]![selectedSemester]!,
                  (value) {
                setState(() {
                  selectedSubject = value;
                });
              }),
            ],
            _buildDropdown(
                'Select Examination', selectedExamination, examinations,
                (value) {
              setState(() {
                selectedExamination = value;
              });
            }),
            const SizedBox(height: 20),
            _buildExcelFilesPreview(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GeneratePage()),
                );
              },
              child: const Text('Generate'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Image.asset(
          "assets/logo.png",
          width: 50,
          height: 50,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.school, size: 50),
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: Text(
            'Pimpri Chinchwad College of Engineering',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown(String hint, String? value, List<String> items,
      Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: hint,
        ),
        value: value,
        items: items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                ))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildExcelFilesPreview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Excel Files Preview:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ...excelFiles.map((file) {
          return ListTile(
            title: Text(file['name']!),
            trailing: const Icon(Icons.file_download),
            onTap: () {
              // Handle file download or opening
            },
          );
        }).toList(),
      ],
    );
  }
}
