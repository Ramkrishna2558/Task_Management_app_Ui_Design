import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final List<Map<String, dynamic>> tasks = [
    {
      'title': 'Create user flow',
      'selected': true,
    },
    {
      'title': 'Create wireframe',
      'selected': false,
    },
    {
      'title': 'Transform to visual design',
      'selected': false,
    },
  ];

  String _selectedOption = 'Weekly';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      iconSize: 28,
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: 16),
                    // Text(
                    //   'Dashboard',
                    //   style: TextStyle(
                    //     fontSize:
                    //     Theme.of(context).textTheme.headline6?.fontSize,
                    //   ),
                    // ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dashboard design',
                  style: TextStyle(
                    fontSize:
                    Theme.of(context).textTheme.headline5?.fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text('Today shared by Ramkrishna'),
                SizedBox(height: 16),
                Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children:[
                      Padding(
                        padding:
                        EdgeInsets.only(left: 40.0, top: 10),
                        child:
                        Transform.scale(
                          scale: 3.0,
                          child:
                          Stack(
                            children: [
                              CircularProgressIndicator(valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.lightGreen), value: 0.85),
                              Positioned.fill(
                                child: Align(
                                  alignment:
                                  Alignment.center,
                                  child:
                                  Text('85%', style:
                                  TextStyle(fontSize:
                                  Theme.of(context).textTheme.subtitle2?.fontSize)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(crossAxisAlignment:
                      CrossAxisAlignment.start, children:[
                        Text(
                          'Teams',
                          style:
                          TextStyle(fontWeight:
                          FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Row(children:[
                          ...['A', 'B', 'C'].map(
                                  (member) =>
                                  Padding(padding:
                                  EdgeInsets.only(right:
                                  8), child:
                                  CircleAvatar(child:
                                  Text(member)))).toList(),
                        ]),
                        SizedBox(height:
                        8),
                        Text('Deadline', style:
                        TextStyle(fontWeight:
                        FontWeight.bold)),
                        SizedBox(height:
                        8),
                        Row(children:[
                          Icon(Icons.calendar_today, size:
                          16),
                          SizedBox(width:
                          4),
                          Text('July 15, 2021 - July 30, 2021')
                        ])
                      ]),
                    ]
                ),
                SizedBox(height:32),
                Padding(padding:
                EdgeInsets.only(top:
                16), child:
                Text('Project Progress', style:
                TextStyle(fontSize:
                Theme.of(context).textTheme.headline6?.fontSize, fontWeight:
                FontWeight.bold))),
                ...tasks.map((task) =>
                    Padding(padding:
                    EdgeInsets.symmetric(vertical:
                    8), child:
                    Row(children:[
                      Icon(task['selected'] ? Icons.check_box : Icons.check_box_outline_blank),
                      SizedBox(width:
                      16),
                      Text(task['title'], style:
                      TextStyle(fontSize:
                      Theme.of(context).textTheme.headline6?.fontSize)),
                    ]))
                ).toList(),
                SizedBox(height:32),
                Row(mainAxisAlignment:
                MainAxisAlignment.spaceBetween, children:[
                  Text('Project Overview', style:
                  TextStyle(fontSize:
                  Theme.of(context).textTheme.labelLarge?.fontSize, fontWeight:
                  FontWeight.bold)),
                  DropdownButton<String>(
                      value:_selectedOption,
                      onChanged:(String? newValue) {
                        setState(() {
                          _selectedOption = newValue!;
                        });
                      },
                      items:<String>['Daily', 'Weekly', 'Monthly'].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value:value,
                            child:Text(value)
                        );
                      }).toList()
                  )
                ]),
                Card(child:SizedBox(height
                    :200, width:double.infinity, child:WaveGraph.withSampleData()))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class WaveGraph extends StatelessWidget {
  final List<charts.Series<dynamic, num>> seriesList;
  final bool animate;

  WaveGraph(this.seriesList, {required this.animate});

  factory WaveGraph.withSampleData() {
    return new WaveGraph(
      _createSampleData(),
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(seriesList, animate: animate);
  }

  static List<charts.Series<LinearSales, num>> _createSampleData() {
    final data = [
      new LinearSales(0, 5),
      new LinearSales(1, 25),
      new LinearSales(2, 100),
      new LinearSales(3, 75),
    ];

    return [
      new charts.Series<LinearSales, num>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}


class LinearSales {
  final num year;
  final int sales;

  LinearSales(this.year, this.sales);
}
