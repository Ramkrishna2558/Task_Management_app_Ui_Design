import 'package:flutter/material.dart';
import 'package:problema/Dashboard design.dart';
class ProjectsPage extends StatefulWidget {
  @override
  _ProjectsPageState createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  int _selectedOptionIndex = 0;
  final List<String> _options = ['All', 'Ongoing', 'Completed'];
  final List<Map<String, dynamic>> projects = [
    {
      'title': 'App animation',
      'shared': 'Shared 2 days ago',
      'by': 'By ram',
      'progress': 0.75,
      'members': ['A', 'B', 'C'],
    },
    {
      'title': 'Dashboard design',
      'shared': 'Shared 1 week ago',
      'by': 'By Ram',
      'progress': 0.5,
      'members': ['D', 'E', 'F'],
    },
    {
      'title': 'UI/UX design',
      'shared': 'Shared 3 days ago',
      'by': 'By Ram',
      'progress': 0.25,
      'members': ['G', 'H', 'I'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            children: [
              Container(
                  padding: EdgeInsets.all(25),
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            iconSize:48,
                            icon: Icon(Icons.account_circle),
                            onPressed: () {},
                          ),
                          SizedBox(width:16),
                          Text('Projects', style:
                          TextStyle(fontSize:
                          Theme.of(context).textTheme.headline6?.fontSize)),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.more_vert),
                        onPressed: () {},
                      ),
                    ],
                  )
              ),
              Container(
                height: 48,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(34),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: _options.map((option) {
                        final index = _options.indexOf(option);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedOptionIndex = index;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            alignment: Alignment.center,
                            child: Text(
                              option,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color:
                                index == _selectedOptionIndex
                                    ? Colors.blue
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: projects.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            if (projects[index]['title'] == "Dashboard design") {
                              Navigator.push(context, MaterialPageRoute(builder:
                                  (context) => DashboardPage()));
                            }
                          },
                          child:
                          Card(
                              margin:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              child:
                              Padding(padding:
                              EdgeInsets.all(16), child:
                              Column(children:[
                                Row(mainAxisAlignment:
                                MainAxisAlignment.spaceBetween, children:[
                                  Column(crossAxisAlignment:
                                  CrossAxisAlignment.start, children:[
                                    Text(projects[index]['title'], style:
                                    TextStyle(fontSize:
                                    Theme.of(context).textTheme.headline6?.fontSize)),
                                    SizedBox(height:8),
                                    Text(projects[index]['shared']),
                                    SizedBox(height:8),
                                    Text(projects[index]['by']),
                                  ]),
                                  Stack(children:[
                                    CircularProgressIndicator(value:
                                    projects[index]['progress']),
                                    Positioned.fill(child:
                                    Align(alignment:
                                    Alignment.center, child:
                                    Text('${(projects[index]['progress'] *100).round()}%'))),
                                  ]),
                                ]),
                                SizedBox(height:16),
                                Row(children:[
                                  ...projects[index]['members'].map((member) =>
                                      Padding(padding:
                                      EdgeInsets.only(right:
                                      8), child:
                                      CircleAvatar(child:
                                      Text(member)))).toList(),
                                ]),
                              ]))),
                        );
                      })),
            ]));
  }
}
