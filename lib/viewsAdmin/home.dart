import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var cake=[
      Sales("Sun", 50, Colors.red),
      Sales("Mon", 70, Colors.blue),
      Sales("Tue", 100, Colors.green),
      Sales("Wed", 200, Colors.purple),
      Sales("Thu", 50, Colors.yellow),
      Sales("Fri", 80, Colors.orange),
      Sales("Sat", 150, Colors.pink),
    ];
    var dessert=[
      Sales("Sun", 150, Colors.red[300]),
      Sales("Mon", 170, Colors.blue[300]),
      Sales("Tue", 10, Colors.green[300]),
      Sales("Wed", 20, Colors.purple[300]),
      Sales("Thu", 60, Colors.yellow[300]),
      Sales("Fri", 180, Colors.orange[300]),
      Sales("Sat", 90, Colors.pink[300]),
    ];
    var drink=[
      Sales("Sun", 100, Colors.red[200]),
      Sales("Mon", 85, Colors.blue[200]),
      Sales("Tue", 120, Colors.green[200]),
      Sales("Wed", 340, Colors.purple[200]),
      Sales("Thu", 150, Colors.yellow[200]),
      Sales("Fri", 110, Colors.orange[200]),
      Sales("Sat", 50, Colors.pink[200]),
    ];

    var series =[
      charts.Series(
        domainFn: (Sales sales,_)=>sales.day,
        measureFn: (Sales sales,_)=>sales.sold,
        colorFn: (Sales sales,_)=>sales.color,
        id: 'Sales',
        data: cake
      ),
      charts.Series(
        domainFn: (Sales sales,_)=>sales.day,
        measureFn: (Sales sales,_)=>sales.sold,
        colorFn: (Sales sales,_)=>sales.color,
        id: 'Sales',
        data: dessert
      ),
      charts.Series(
        domainFn: (Sales sales,_)=>sales.day,
        measureFn: (Sales sales,_)=>sales.sold,
        colorFn: (Sales sales,_)=>sales.color,
        id: 'Sales',
        data: drink
      ),
    ];

    var chart = charts.BarChart(
      series,
      barGroupingType: charts.BarGroupingType.grouped,
      vertical: false,
    );

    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.purple,
        title: Text('GRAFIC'),
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.search, color: Colors.white), onPressed: () {})
        ],
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            Text("S a l e s  A n a l y s i s", style: TextStyle(fontSize: 20),),
            SizedBox(
              child: chart,
              height: 400,
            ),
          ],
        ),
      ),
    );
  }
}

 class Sales {
   final String day;
   final int sold;
   final charts.Color color;

   Sales(this.day, this.sold, Color color)
   :this.color=charts.Color(r: color.red,g: color.green, b: color.blue, a: color.alpha)
   ;
 }