import 'package:flutter/material.dart';
import 'package:question_nswer/ui/screens/questions_details_screen.dart';
import 'package:question_nswer/ui/screens/post_questions_screen.dart';
import 'package:question_nswer/ui/screens/proposals_screen.dart';
import 'package:question_nswer/ui/screens/contracts_screen.dart';
import 'package:question_nswer/ui/screens/alerts_screen.dart';
import 'package:question_nswer/ui/screens/messages_screen.dart';

void main() => runApp(AnswersApp());

class AnswersApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Answers App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // List of screens for each tab
  final List<Widget> _screens = [
    QuestionsScreen(),
    ProposalsScreen(),
    ContractsScreen(),
    MessagesScreen(),
    AlertsScreen(),
  ];

  // Handle BottomNavigationBar tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Answers App'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Navigate to profile or user account settings
            },
          )
        ],
      ),
      body: _screens[_selectedIndex], // Display the selected screen
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostQuestionScreen(),
                  ),
                );
              },
              child: Icon(Icons.add),
            )
          : null, // Show FloatingActionButton only on Questions tab
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer),
            label: 'Questions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Proposals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Contracts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Alerts',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped, // Update the selected index
      ),
    );
  }
}

// Example screen for Questions tab
class QuestionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              hintText: 'Search for questions...',
              hintStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          SizedBox(height: 20),
          // Recent Questions Header
          Text(
            'Recent Questions',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          // Modern ListView for Questions
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 16,
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue,
                          child:
                              Icon(Icons.question_answer, color: Colors.white),
                        ),
                        title: Text(
                          'Question Title $index',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'This is a brief description of the question. Tap to view more details.',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 8),
                              Text('Paid: \$${(index + 1) * 5}',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.green)),
                              Text('Answered in: ${index + 2} hours',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey)),
                            ],
                          ),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  QuestionDetailScreen(questionIndex: index),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  icon:
                                      Icon(Icons.thumb_down, color: Colors.red),
                                  onPressed: () {
                                    // Handle dislike logic
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.favorite_border,
                                      color: Colors.pink),
                                  onPressed: () {
                                    // Handle like logic
                                  },
                                ),
                              ],
                            ),
                            Text('${(index + 1) * 10} Likes',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Placeholder screen for question details
class QuestionDetailScreen extends StatelessWidget {
  final int questionIndex;

  QuestionDetailScreen({required this.questionIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question Details'),
      ),
      body: Center(
        child: Text('Details for Question $questionIndex'),
      ),
    );
  }
}

// Screen for Messages tab
class MessagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              leading: Stack(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 5,
                      backgroundColor: index % 2 == 0
                          ? Colors.green
                          : Colors.red, // Active or inactive
                    ),
                  ),
                ],
              ),
              title: Text('User $index',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Question Title $index',
                      style: TextStyle(color: Colors.black54, fontSize: 14)),
                  SizedBox(height: 4),
                  Text('This is a preview of the message...',
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                ],
              ),
              trailing: Text('12:3${index} PM',
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatDetailScreen(userIndex: index),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// Chat Detail Screen
class ChatDetailScreen extends StatelessWidget {
  final int userIndex;

  ChatDetailScreen({required this.userIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with User $userIndex'),
        actions: [
          IconButton(
            icon: Icon(Icons.video_call),
            onPressed: () {
              // Video call functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.call),
            onPressed: () {
              // Voice call functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 15,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: index % 2 == 0
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Container(
                      decoration: BoxDecoration(
                        color: index % 2 == 0
                            ? Colors.grey[300]
                            : Colors.blue[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.all(12),
                      child: Text(
                        'Message $index',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.attach_file),
                  onPressed: () {
                    // Handle file attachment
                  },
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Handle message sending
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
