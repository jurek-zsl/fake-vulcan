import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School Schedule',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        scaffoldBackgroundColor: Colors.grey,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: FakeSchedulePage(),
      routes: {
        '/grades': (context) => GradesPage(),
        '/messages': (context) => MessagesPage(),
        '/home': (context) => HomePage(),
        '/schedule': (context) => FakeSchedulePage(),
      },
    );
  }
}

class FakeSchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<FakeSchedulePage> {
  int _selectedIndex = 2;
  int _selectedDay = 0;
  bool _isSubstitutionsSelected = false;
  List<String> weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  List<String> months = ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'];
  Map<String, List<Lesson>> schedule = {
    'Mon': [
      Lesson('Fizyka', '08:15 - 09:00', true, 2),
      Lesson('Geografia', '09:10 - 09:55', true, 3),
      Lesson('Wychowanie fizyczne', '10:05 - 10:50', true, 4),
      Lesson('Zajęcia z wychowawcą', '11:00 - 11:45', true, 5),
      Lesson('Język niemiecki', '12:05 - 12:50', true, 6),
      Lesson('Matematyka', '13:00 - 13:45', true, 7),
      Lesson('Język polski', '13:55 - 14:40', true, 8),
      Lesson('Język polski', '14:50 - 15:35', true, 9),
    ],
    'Tue': [
      Lesson('systemy teleinformatyczne', '07:20 - 08:05', true, 1),
      Lesson('Historia i teraźniejszość', '08:15 - 09:00', true, 2),
      Lesson('podstawy sieci komputerowych', '09:10 - 09:55', true, 3),
      Lesson('pracownia systemow operacyjnych', '10:05 - 10:50', true, 4),
      Lesson('pracownia systemow operacyjnych', '11:00 - 11:45', true, 5),
      Lesson('pracownia systemow operacyjnych', '12:05 - 12:50', true, 6),
      Lesson('podstawy elektrotechniki', '13:00 - 13:45', true, 7),
    ], 
    'Wed': [
      Lesson('Język niemiecki', '07:20 - 08:05', true, 1),
      Lesson('Historia', '08:15 - 09:00', true, 2),
      Lesson('Matematyka', '09:10 - 09:55', true, 3),
      Lesson('Wychowanie fizyczne', '10:05 - 10:50', true, 4),
      Lesson('Informatyka', '11:00 - 11:45', true, 5),
      Lesson('Język polski', '12:05 - 12:50', true, 6),
      Lesson('pracownia teleinformatyczna', '13:00 - 13:45', true, 7),
      Lesson('pracownia teleinformatyczna', '13:55 - 14:40', true, 8),
    ], 
    'Thu': [
      Lesson('Język niemiecki', '07:20 - 08:05', true, 1),
      Lesson('sieci komputerowe', '08:15 - 09:00', true, 2),
      Lesson('sieci komputerowe', '09:10 - 09:55', true, 3),
      Lesson('bezpieczeństwo i higiena pracy', '10:05 - 10:50', true, 4),
      Lesson('Fizyka', '11:00 - 11:45', true, 5),
      Lesson('Wychowanie fizyczne', '12:05 - 12:50', true, 6),
      Lesson('Jezyk angielski', '13:00 - 13:45', true, 7),
      Lesson('Biznes i zarządzanie', '13:55 - 14:40', true, 8),
    ], 
    'Fri': [
      Lesson('Biologia', '08:15 - 09:00', true, 2),
      Lesson('Matematyka', '09:10 - 09:55', true, 3),
      Lesson('Chemia', '10:05 - 10:50', true, 4),
      Lesson('pracownia komputerowego wspomagania projektowania', '11:00 - 11:45', true, 5),
      Lesson('pracownia komputerowego wspomagania projektowania', '12:05 - 12:50', true, 6),
      Lesson('Język angielski', '13:00 - 13:45', true, 7),
    ], 
    'Sat': [], 
    'Sun': [],
  };

  List<DateTime> getCurrentWeekDates() {
    DateTime now = DateTime.now();
    int currentWeekday = now.weekday;
    DateTime monday = now.subtract(Duration(days: currentWeekday - 1));
    return List.generate(7, (index) => monday.add(Duration(days: index)));
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text('Schedule', style: TextStyle(color: Colors.white, fontSize: 18),),
      actions: [
        IconButton(
          icon: Icon(Icons.account_circle, color: Colors.white, size: 30),
          onPressed: () {
        // Add your profile icon action here
          },
        ),
      ],
      backgroundColor: Color(0xff7200ca),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> currentWeekDates = getCurrentWeekDates();

    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        color: Color(0xff121212),
        child: Column(
          children: [
            Container(
              height: 55,
              color: Color(0xff7200ca),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isSubstitutionsSelected = false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: _isSubstitutionsSelected ? Colors.transparent : Colors.white, width: 2.0),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Schedule',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isSubstitutionsSelected = true;
                          _showAddLessonModal(context);
                        });
                        
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: _isSubstitutionsSelected ? Colors.white : Colors.transparent, width: 2.0),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Substitutions',
                            style: TextStyle(color: Colors.white.withOpacity(0.5)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 60,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      months[DateTime.now().month - 1].toUpperCase(),
                      style: TextStyle(color: Color(0xff7200ca), fontWeight: FontWeight.w300,),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        DateTime date = currentWeekDates[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedDay = index;
                            });
                          },
                          child: Container(
                            width: 60,
                            color: _selectedDay == index ? Colors.transparent : Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  weekDays[index],
                                  style: TextStyle(
                                    color: _selectedDay == index ? Color(0xff7200ca) : Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${date.day}',
                                  style: TextStyle(
                                    color: _selectedDay == index ? Color(0xff7200ca) : Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ReorderableListView(
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (newIndex > oldIndex) {
                      newIndex -= 1;
                    }
                    final lesson = schedule[weekDays[_selectedDay]]!.removeAt(oldIndex);
                    schedule[weekDays[_selectedDay]]!.insert(newIndex, lesson);

                    // Update lesson numbers
                    for (int i = 0; i < schedule[weekDays[_selectedDay]]!.length; i++) {
                      schedule[weekDays[_selectedDay]]![i].lessonNumber = i + 1;
                    }
                  });
                },
                children: List.generate(schedule[weekDays[_selectedDay]]!.length, (index) {
                  final lesson = schedule[weekDays[_selectedDay]]![index];
                  if (!lesson.isVisible) return SizedBox.shrink();
                  return Container(
                    key: ValueKey(lesson),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Color(0xff242424))),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 75,
                          color: lesson.isCanceled ? Color(0xff7200ca) : Colors.transparent,
                        ),
                        Expanded(
                          child: ListTile(
                            leading: Text(
                              '${lesson.lessonNumber}.',
                              style: TextStyle(color: Color(0xff7200ca), fontSize: 18),
                            ),
                            title: Text(
                              lesson.name,
                              style: TextStyle(
                                color: Colors.white,
                                decoration: lesson.isCanceled ? TextDecoration.lineThrough : TextDecoration.none,
                                decorationColor: const Color.fromARGB(255, 175, 175, 175),
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(lesson.time, style: TextStyle(color: Colors.white70)),
                                if (lesson.isCanceled)
                                  Text(
                                    'Canceled',
                                    style: TextStyle(
                                      color: const Color.fromARGB(255, 255, 255, 255),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                              ],
                            ),
                            trailing: lesson.isCanceled
                                ? null
                                : Icon(Icons.check_circle, color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;            
            case 1:
              Navigator.pushReplacementNamed(context, '/messages');
              break;
            case 2:
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/grades');
              break;
            case 4:
              _showMoreMenu();
              break;
          }
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: const Color.fromARGB(255, 238, 238, 238),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Start'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Schedule'),
          BottomNavigationBarItem(icon: Icon(Icons.grade), label: 'Grades'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
      ),
    );
  }
  
  void _showMoreMenu() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              child: ListView.builder(
                itemCount: weekDays.length,
                itemBuilder: (context, dayIndex) {
                  return ExpansionTile(
                    title: Text(weekDays[dayIndex]),
                    children: schedule[weekDays[dayIndex]]!.map((lesson) {
                      return Row(
                        children: [
                          Expanded(
                            child: CheckboxListTile(
                              title: Text(lesson.name),
                              subtitle: Text(lesson.time),
                              value: lesson.isVisible,
                              onChanged: (bool? value) {
                                setModalState(() {
                                  lesson.isVisible = value!;
                                });
                                setState(() {});
                              },
                            ),
                          ),
                          Expanded(
                            child: CheckboxListTile(
                              title: Text('Cancel'),
                              value: lesson.isCanceled,
                              onChanged: (bool? value) {
                                setModalState(() {
                                  lesson.isCanceled = value!;
                                });
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

void _showAddLessonModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // This allows the modal to resize when the keyboard appears
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, // Adjusts the padding when the keyboard appears
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Lesson Name'),
                  style: TextStyle(color: Colors.black),
                ),
                TextField(
                  controller: idController,
                  decoration: InputDecoration(labelText: 'Lesson Number'),
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.black),
                ),
                TextField(
                  controller: timeController,
                  decoration: InputDecoration(labelText: 'Time'),
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      schedule[weekDays[_selectedDay]]!.add(
                        Lesson(
                          nameController.text,
                          timeController.text,
                          true,
                          int.parse(idController.text),
                        ),
                      );
                    });
                    Navigator.pop(context);
                  },
                  child: Text('Add Lesson'),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
}

class Lesson {
  final String name;
  final String time;
  bool isVisible;
  bool isCanceled;
  int lessonNumber;

  Lesson(this.name, this.time, this.isVisible, this.lessonNumber, {this.isCanceled = false});
}

class GradesPage extends StatelessWidget {
  const GradesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Grades', style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xff7200ca),
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle, color: Colors.white, size: 30,),
            onPressed: () {
              // Add your profile icon action here
            },
          ),         
        ],
      ),
      body: Center(
        child: Text('Grades', style: TextStyle(color: Colors.white)),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home');
              break;            
            case 1:
              Navigator.pushNamed(context, '/messages');
              break;
            case 2:
              Navigator.pushNamed(context, '/schedule');
              break;
            case 3:
              break;
            case 4:
              // Add your more menu action here
              break;
          }
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: const Color.fromARGB(255, 238, 238, 238),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Start'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Schedule'),
          BottomNavigationBarItem(icon: Icon(Icons.grade), label: 'Grades'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int luckyNumber = 1;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _generateLuckyNumber();
  }

  void _generateLuckyNumber() {
    final random = Random();
    setState(() {
      luckyNumber = random.nextInt(32) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff121212),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Dzienniczek VULCAN', style: TextStyle(color: Colors.white, fontSize: 18),),
        backgroundColor: Color(0xff7200ca),
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle, color: Colors.white, size: 30),
            onPressed: () {
              // Add your profile icon action here
            },
          ),         
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 0, right: 0, top: 4, bottom: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCurrentLesson(),
              Spacer(),
              _buildShowAllGradesButton(),
              SizedBox(height: 10),
              _buildBottomButtons(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          switch (index) {
            case 0:
              // Already on home page
              break;            
            case 1:
              Navigator.pushNamed(context, '/messages');
              break;
            case 2:
              Navigator.pushNamed(context, '/schedule');
              break;
            case 3:
              Navigator.pushNamed(context, '/grades');
              break;
            case 4:
              // Add your more menu action here
              break;
          }
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: const Color.fromARGB(255, 238, 238, 238),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Start'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Schedule'),
          BottomNavigationBarItem(icon: Icon(Icons.grade), label: 'Grades'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
      ),
    );
  }

  Widget _buildCurrentLesson() {
    return Column(
      children: [
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CURRENT LESSON',
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'NO CURRENT LESSON',
                    style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'LUCKY',
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                  Text(
                    'NUMBER',
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                  SizedBox(height: 2),
                  Text(
                    '$luckyNumber',
                    style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildShowAllGradesButton() {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0), // Add padding on the sides
        child: ElevatedButton(
          onPressed: () {
            // Add action for showing all grades
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 16), 
            backgroundColor: Color(0xff121212),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
              side: BorderSide(color: const Color.fromARGB(255, 44, 44, 44)),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Show all grades',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                Icon(Icons.chevron_right, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNewSection(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildBottomButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildBottomButton(Icons.grade, 'New grades', Color(0xff7200ca)),
        _buildBottomButton(Icons.people, 'New attendance', Colors.grey[900]!),
        _buildBottomButton(Icons.book, 'New homework', Colors.grey[900]!),
      ],
    );
  }

  Widget _buildBottomButton(IconData icon, String label, Color color) {
    return Container(
      width: 105,
      height: 110,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 32),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class MessagesPage extends StatefulWidget {
  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  int _selectedIndex = 1; // Set to 1 for Messages tab
  List<Map<String, String>> messages = [
    {
      'initials': 'AC',
      'sender': 'CIERZNIAKOWSKA MARTA - P - (ZS...',
      'subject': 'Konkursu fotograficzny Natio...',
      'date': '02.10.2024\n08:39',
    },
    {
      'initials': 'AS',
      'sender': 'SZKLARSKI RAFAŁ - P - (ZSŁ)',
      'subject': 'FW: FW: Historia Telekomunik...',
      'date': '01.10.2024\n07:58',
    },
    {
      'initials': 'AT',
      'sender': 'TYSZER MAGDALENA - P - (ZSŁ)',
      'subject': 'Klub Debat',
      'date': '30.09.2024\n11:32',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff121212),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Messages', style: TextStyle(color: Colors.white, fontSize: 18)),
        backgroundColor: Color(0xff7200ca),
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle, color: Colors.white, size: 30),
            onPressed: () {
              // Add your profile icon action here
            },
          ),         
        ],
      ),
      body: Column(
        children: [
          _buildTabs(),
          Expanded(
            child: _buildMessageList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddMailModal(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xff7200ca),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;            
            case 1:
              // Already on messages page
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/schedule');
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/grades');
              break;
            case 4:
              break;
          }
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: const Color.fromARGB(255, 238, 238, 238),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Start'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Schedule'),
          BottomNavigationBarItem(icon: Icon(Icons.grade), label: 'Grades'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      color: Color(0xff7200ca),
      child: Row(
        children: [
          Expanded(
            child: _buildTab('Received', isActive: true),
          ),
          Expanded(
            child: _buildTab('Sent'),
          ),
          Expanded(
            child: _buildTab('Deleted'),
          ),
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.white),
            onPressed: () {
              // Add filter action
            },
          ),
        ],
      ),
    );
  }

  TextEditingController initialsController = TextEditingController();
  TextEditingController senderController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  void _showAddMailModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: initialsController,
              decoration: InputDecoration(labelText: 'Initials'),
            ),
            TextField(
              controller: senderController,
              decoration: InputDecoration(labelText: 'Sender'),
            ),
            TextField(
              controller: subjectController,
              decoration: InputDecoration(labelText: 'Subject'),
            ),
            TextField(
              controller: dateController,
              decoration: InputDecoration(labelText: 'Date'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  messages.add({
                    'initials': initialsController.text,
                    'sender': senderController.text,
                    'subject': subjectController.text,
                    'date': dateController.text,
                  });
                });
                Navigator.pop(context);
              },
              child: Text('Add Mail'),
            ),
          ],
        ),
      );
    },
  );
}
  
  Widget _buildTab(String title, {bool isActive = false}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isActive ? Colors.white : Colors.transparent,
            width: 2,
          ),
        ),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    List<Map<String, String>> messages = [
      {
        'initials': 'AC',
        'sender': 'CIERZNIAKOWSKA MARTA - P - (ZS...',
        'subject': 'Konkursu fotograficzny Natio...',
        'date': '02.10.2024\n08:39',
      },
    ];

    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return _buildMessageItem(messages[index]);
      },
    );
  }

  Widget _buildMessageItem(Map<String, String> message) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[800]!, width: 0.5),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Color(0xff7200ca),
          child: Text(message['initials']!, style: TextStyle(color: Colors.white)),
        ),
        title: Text(
          message['sender']!,
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        subtitle: Text(
          message['subject']!,
          style: TextStyle(color: Colors.grey[400], fontSize: 12),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message['date']!.split('\n')[0],
              style: TextStyle(color: Colors.grey[400], fontSize: 12),
            ),
            Text(
              message['date']!.split('\n')[1],
              style: TextStyle(color: Colors.grey[400], fontSize: 12),
            ),
            Icon(Icons.star_border, color: Colors.grey[400], size: 20),
          ],
        ),
      ),
    );
  }
}

class MailDetailsPage extends StatelessWidget {
  final Map<String, String> mail;

  MailDetailsPage({required this.mail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mail Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sender: ${mail['sender']}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Subject: ${mail['subject']}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Date: ${mail['date']}', style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}