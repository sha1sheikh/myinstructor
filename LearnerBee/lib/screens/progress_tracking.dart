import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgressTrackingScreen extends StatelessWidget {
  const ProgressTrackingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Skill data model
    final List<SkillProgress> skills = [
      SkillProgress('Parallel Parking', 0.6),
      SkillProgress('Highway Driving', 0.9),
      SkillProgress('Defensive Driving', 0.7),
      SkillProgress('Night Driving', 0.5),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFFF6D6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF6D6),
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'My Progress',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overall Progress Card
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: const BorderSide(color: Color(0xFFE6D9B2), width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Overall Progress',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        CircularPercentIndicator(
                          radius: 40.0,
                          lineWidth: 10.0,
                          percent: 0.75,
                          center: const Text(
                            '75%',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          backgroundColor: const Color(0xFFE6D9B2),
                          progressColor: const Color(0xFF8B6D47),
                        ),
                        const SizedBox(width: 30),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Lessons completed: 12/16'),
                              SizedBox(height: 10),
                              Text('Hours driven: 18.5'),
                              SizedBox(height: 10),
                              Text('Skills mastered: 8/12'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Skill Progress Section
            const Text(
              'Skill Progress',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            
            // Skill Progress Bars
            ...skills.map((skill) => Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(skill.name),
                      Text('${(skill.progress * 100).toInt()}%'),
                    ],
                  ),
                  const SizedBox(height: 5),
                  LinearProgressIndicator(
                    value: skill.progress,
                    backgroundColor: const Color(0xFFE6D9B2),
                    color: const Color(0xFF8B6D47),
                    minHeight: 16,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ],
              ),
            )).toList(),
            
            // Instructor Notes Section
            const Text(
              'Instructor Notes',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            
            // Note Card
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: const BorderSide(color: Color(0xFFE6D9B2), width: 1),
              ),
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'From Michael Santos - April 10:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('Great progress on highway merging today! Let\'s focus more on parallel parking next session. Remember the 45° angle approach we practiced.'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Schedule Next Lesson Button
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to scheduling screen
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B6D47),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Schedule Next Lesson',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_back),
            label: '',
          ),
        ],
      ),
    );
  }
}

// Model class for skill progress
class SkillProgress {
  final String name;
  final double progress;

  SkillProgress(this.name, this.progress);
}