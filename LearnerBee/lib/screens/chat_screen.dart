import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'instructor_detail_screen.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;
  String _apiKey = '';
  
  // Sample instructor data - in a real app, this would come from a database
  final List<Map<String, dynamic>> instructors = [
    {
      'name': 'John Smith',
      'specialty': 'Beginner drivers, anxiety management',
      'experience': '15 years',
      'location': 'Downtown',
      'rating': 4.8,
      'hourlyRate': '\$45',
      'availability': 'Weekdays and Saturday mornings',
    },
    {
      'name': 'Maria Garcia',
      'specialty': 'Highway driving, defensive techniques',
      'experience': '8 years',
      'location': 'Westside',
      'rating': 4.9,
      'hourlyRate': '\$50',
      'availability': 'Afternoons and weekends',
    },
    {
      'name': 'David Chen',
      'specialty': 'Manual transmission, advanced skills',
      'experience': '12 years',
      'location': 'Eastside',
      'rating': 4.7,
      'hourlyRate': '\$55',
      'availability': 'Weekday evenings and Sundays',
    },
    {
      'name': 'Sarah Johnson',
      'specialty': 'Teen drivers, test preparation',
      'experience': '6 years',
      'location': 'Suburbs',
      'rating': 4.6,
      'hourlyRate': '\$40',
      'availability': 'Flexible schedule',
    },
    {
      'name': 'Ahmed Patel',
      'specialty': 'Senior refresher courses, parallel parking',
      'experience': '20 years',
      'location': 'City center',
      'rating': 5.0,
      'hourlyRate': '\$60',
      'availability': 'Mornings only',
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadApiKey();
    _addBotMessage("Welcome! Tell me about your driving experience and what you're looking for in an instructor. Include details like your skill level, specific areas you want to improve, preferred location, and availability.");
  }

  void _loadApiKey() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _apiKey = prefs.getString('openai_api_key') ?? '';
    });
    
    if (_apiKey.isEmpty) {
      _promptForApiKey();
    }
  }

  void _saveApiKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('openai_api_key', key);
    setState(() {
      _apiKey = key;
    });
  }

  void _promptForApiKey() {
    final apiKeyController = TextEditingController();
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter OpenAI API Key'),
          content: TextField(
            controller: apiKeyController,
            decoration: InputDecoration(
              hintText: 'sk-...',
            ),
            obscureText: true,
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (apiKeyController.text.isNotEmpty) {
                  _saveApiKey(apiKeyController.text);
                  Navigator.pop(context);
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _handleSubmitted(String text) async {
    if (text.isEmpty) return;
    
    _textController.clear();
    
    setState(() {
      _messages.add(
        ChatMessage(
          text: text,
          isUserMessage: true,
        ),
      );
      _isLoading = true;
    });

    // Call OpenAI API and process the response
    try {
      final response = await _sendToOpenAI(text);
      List<Map<String, dynamic>> matchedInstructors = await _matchInstructors(text, response);
      
      // Add GPT's direct response
      _addBotMessage(response);
      
      // Add matched instructors
      if (matchedInstructors.isNotEmpty) {
        _addBotInstructorsList(matchedInstructors);
      } else {
        _addBotMessage("I couldn't find any instructors matching your criteria. Could you provide more details about what you're looking for?");
      }
    } catch (e) {
      _addBotMessage("Sorry, I encountered an error while processing your request: ${e.toString()}");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _addBotMessage(String message) {
    setState(() {
      _messages.add(
        ChatMessage(
          text: message,
          isUserMessage: false,
        ),
      );
    });
  }

  void _addBotInstructorsList(List<Map<String, dynamic>> instructorList) {
    final instructorsText = "Based on your requirements, here are some instructors that might be a good match:";
    
    setState(() {
      _messages.add(
        ChatMessage(
          text: instructorsText,
          isUserMessage: false,
        ),
      );
      
      _messages.add(
        ChatMessage(
          instructorList: instructorList,
          isUserMessage: false,
          isInstructorList: true,
        ),
      );
    });
  }

  Future<String> _sendToOpenAI(String userMessage) async {
    if (_apiKey.isEmpty) {
      _promptForApiKey();
      throw Exception("API key not provided");
    }
    
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
    
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {
              'role': 'system',
              'content': 'You are a helpful assistant that matches driving students with appropriate instructors. Analyze the user\'s driving experience, goals, and preferences to determine what type of instructor would be best for them. Do not recommend specific instructors by name yet, just analyze their needs and situation.'
            },
            {
              'role': 'user',
              'content': userMessage
            }
          ],
          'temperature': 0.7,
          'max_tokens': 500,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'];
      } else {
        throw Exception('Failed to get response: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Error connecting to OpenAI: $e');
    }
  }

  Future<List<Map<String, dynamic>>> _matchInstructors(String userInput, String aiResponse) async {
    // Create a combined text for the second OpenAI call to match instructors
    final matchingPrompt = """
User input: $userInput

AI analysis: $aiResponse

Based on the above information, match this user with suitable instructors from the following list. Provide the indices (0-based) of the top 2-3 most suitable instructors, formatted as a comma-separated list like [0,3,4]:

${instructors.asMap().entries.map((e) => "${e.key}: ${jsonEncode(e.value)}").join("\n\n")}
""";

    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
    
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {
              'role': 'system',
              'content': 'You are a matching system that pairs driving students with instructors. Respond only with a JSON array of indices, e.g. [0,3,4].'
            },
            {
              'role': 'user',
              'content': matchingPrompt
            }
          ],
          'temperature': 0.3,
          'max_tokens': 100,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final content = data['choices'][0]['message']['content'];
        
        // Extract indices from the response, handling different formats
        List<int> indices = [];
        try {
          // Try to parse as JSON
          final match = RegExp(r'\[([0-9,\s]+)\]').firstMatch(content);
          if (match != null) {
            final indexString = match.group(1)!;
            indices = indexString.split(',')
                .map((s) => int.tryParse(s.trim()) ?? -1)
                .where((i) => i >= 0 && i < instructors.length)
                .toList();
          }
        } catch (e) {
          print('Error parsing indices: $e');
        }
        
        // If we couldn't parse indices or got none, return the first 2 instructors as fallback
        if (indices.isEmpty) {
          indices = [0, 1];
        }
        
        // Return the matched instructors
        return indices.map((i) => instructors[i]).toList();
      } else {
        throw Exception('Failed to match instructors: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Error in instructor matching: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Instructor Matcher'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: _promptForApiKey,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: false,
              itemCount: _messages.length,
              itemBuilder: (_, int index) => _messages[index],
            ),
          ),
          Divider(height: 1.0),
          _buildTextComposer(),
          if (_isLoading)
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Tell me about your driving experience...',
              ),
              onSubmitted: _isLoading ? null : _handleSubmitted,
              enabled: !_isLoading,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _isLoading ? null : () => _handleSubmitted(_textController.text),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String? text;
  final bool isUserMessage;
  final bool isInstructorList;
  final List<Map<String, dynamic>>? instructorList;

  ChatMessage({
    this.text,
    required this.isUserMessage,
    this.isInstructorList = false,
    this.instructorList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: isUserMessage ? Color(0xFF8B6C42) : Colors.green,
              child: Icon(
                isUserMessage ? Icons.person : Icons.smart_toy,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isUserMessage ? 'You' : 'Assistant',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5.0),
                  child: isInstructorList
                      ? _buildInstructorList(context)
                      : Text(text ?? ''),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructorList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: instructorList!.map((instructor) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      instructor['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, size: 18.0, color: Colors.amber),
                        Text(
                          instructor['rating'].toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                _buildInstructorDetail('Specialty', instructor['specialty']),
                _buildInstructorDetail('Experience', instructor['experience']),
                _buildInstructorDetail('Location', instructor['location']),
                _buildInstructorDetail('Rate', instructor['hourlyRate']),
                _buildInstructorDetail('Availability', instructor['availability']),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Instead of just calling a function, navigate to the detail screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InstructorDetailScreen(
                              instructor: instructor,
                            ),
                          ),
                        );
                      },
                      child: Text('View Details'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildInstructorDetail(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}