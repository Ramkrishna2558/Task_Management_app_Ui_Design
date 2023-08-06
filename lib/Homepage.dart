import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String userName = 'Harsha';
  final List<Map<String, dynamic>> tasks = [
    {
      'title': 'App animation',
      'progress': 0.75,
      'selected': true,
      'members': ['A', 'B', 'C'],
    },
    {
      'title': 'Dashboard design',
      'progress': 0.5,
      'selected': false,
      'members': ['D', 'E', 'F'],
    },
    {
      'title': 'UI/UX design',
      'progress': 0.25,
      'selected': true,
      'members': ['G', 'H', 'I'],
    },
  ];
  final List<Map<String, dynamic>> gridItems = [
    {
      'title': 'In Progress',
      'color': Color(0xFFFFC277),
      'icon': Icons.access_time,
    },
    {
      'title': 'Ongoing',
      'color': Color(0xFF9297FF),
      'icon': Icons.play_circle_fill,
    },
    {
      'title': 'Completed',
      'color': Color(0xFFC2EA94),
      'icon': Icons.check_circle,
    },
    {
      'title': 'Canceled',
      'color': Color(0xFFFF7648),
      'icon': Icons.cancel,
    },
  ];
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          Container(
              padding: EdgeInsets.all(25),
              child: Row(children: [
                IconButton(
                  iconSize: 48,
                  icon: Icon(Icons.account_circle),
                  onPressed: () {},
                ),
                // SizedBox(width: 16),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hello',
                          style: TextStyle(
                              fontSize:
                              (Theme.of(context).textTheme.subtitle1?.fontSize ?? 14) * 1.3)),
                      Text(userName,
                          style: TextStyle(
                              fontSize:
                              (Theme.of(context).textTheme.headline6?.fontSize ?? 20) * 1.2,
                              fontWeight: FontWeight.bold)),
                    ])
              ])),
          Padding(
              padding: EdgeInsets.all(25),
              child: GridView.count(
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  children: gridItems.map((item) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: Card(
                        color: item['color'],
                        child: Stack(
                          children: [
                            if (item['title'] == 'In Progress')
                              Positioned(
                                top: -15,
                                left: 25,
                                child: ClipPath(
                                  clipper: CircleClipper(),
                                  child: Container(
                                    width: 45,
                                    height: 45,
                                    color: Color(0xffFF996E),
                                  ),
                                ),
                              ),
                            if (item['title'] == 'Completed')
                              Positioned(
                                bottom: 35,
                                left: -15,
                                child: ClipPath(
                                  clipper: CircleClipper(),
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    color: Color(0xffB1D985),
                                  ),
                                ),
                              ),
                            if (item['title'] == "Canceled")
                              Positioned(
                                top:
                                -15, left:
                              item['title'] == "Canceled" ? MediaQuery.of(context).size.width * .2 : -15, //20% from left side
                                child:
                                ClipPath(clipper:
                                CircleClipper(), child:
                                Container(width:
                                40, height:
                                40, color:
                                Color(0xffFFC277))),
                              ),
                            Center(child:
                            Column(mainAxisAlignment:
                            MainAxisAlignment.center, children:[
                              Icon(item['icon'], size:
                              36),
                              SizedBox(height:
                              8),
                              Text(item['title'])
                            ])),
                          ],
                        ),
                      ),
                    );
                  }).toList())),
          Padding(padding:
          EdgeInsets.symmetric(horizontal:
          16), child:
          Row(mainAxisAlignment:
          MainAxisAlignment.spaceBetween, children:[
            Text('Daily Tasks', style:
            TextStyle(fontSize:
            Theme.of(context).textTheme.headline6?.fontSize, fontWeight:
            FontWeight.bold)),
            Row(children:[
              Text('All Tasks', style:
              TextStyle(fontSize:
              Theme.of(context).textTheme.headline6?.fontSize)),
              IconButton(icon:
              Icon(_isExpanded ? Icons.expand_less : Icons.expand_more), onPressed:
                  () => setState(() => _isExpanded = !_isExpanded))
            ])
          ])),
          if (_isExpanded)
            Expanded(child:
            ListView.builder(itemCount:
            tasks.length, itemBuilder:
                (context, index) {
              return Container(decoration:
              BoxDecoration(border:
              Border.all(color:
              Colors.grey), borderRadius:
              BorderRadius.circular(8)), child:
              Card(margin:
              EdgeInsets.symmetric(horizontal:
              16, vertical:
              8), shape:
              RoundedRectangleBorder(borderRadius:
              BorderRadius.circular(8)), child:
              Padding(padding:
              EdgeInsets.all(16), child:
              Column(children:[
                Row(mainAxisAlignment:
                MainAxisAlignment.spaceBetween, children:[
                  Row(children:[
                    Icon(tasks[index]['selected'] ? Icons.check_box : Icons.check_box_outline_blank),
                    SizedBox(width:
                    8),
                    Text(tasks[index]['title'], style:
                    TextStyle(fontSize:
                    Theme.of(context).textTheme.headline6?.fontSize)),
                  ]),
                ]),
                SizedBox(height:
                8),
                Row(children:[
                  Expanded(flex:
                  1, child:
                  LinearProgressIndicator(value:
                  tasks[index]['progress'], backgroundColor:
                  Colors.grey[200], valueColor:
                  AlwaysStoppedAnimation<Color>(Colors.blue))),
                  SizedBox(width: 8),
                  Expanded(flex: 1, child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    ...tasks[index]['members'].map((member) => InkWell(onTap: () {}, child: CircleAvatar(child: Text(member), radius:12))),
                    IconButton(icon: Icon(Icons.arrow_forward), onPressed: () {
                      // Navigate to a new page here
                    }),
                  ]))
                ]),
              ]))),
              );
            })),
        ]));
  }
}

class CircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.addOval(Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: size.width / 2));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
