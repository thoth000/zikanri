import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

import '../data.dart';

class CategoryPage extends StatelessWidget {
  final int index;
  CategoryPage(this.index);
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context, listen: false);
    Color color = (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    Color subcolor = (theme.isDark) ? Colors.grey[700] : Colors.grey[200];
    final GlobalKey<AnimatedCircularChartState> _chartKey =
        new GlobalKey<AnimatedCircularChartState>();
    final list = userData.categories[index];
    int icon = list[0];
    String title = list[1];
    List<int> values = list[2];
    List<CircularStackEntry> data = <CircularStackEntry>[
      new CircularStackEntry(
        <CircularSegmentEntry>[
          new CircularSegmentEntry(
            values[1].toDouble(),
            color,
            rankKey: 'Q1',
          ),
          new CircularSegmentEntry(
            (values[0] == 0) ? 1 : (values[0] - values[1]).toDouble(),
            subcolor,
            rankKey: 'Q2',
          ),
        ],
        rankKey: 'Quarterly Profits',
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal:displaySize.width/20),
        child: Column(
          children: <Widget>[
            SizedBox(height: 10,),
            Row(
              children: <Widget>[
                Icon(IconData(icon,fontFamily: 'MaterialIcons'),
                size: displaySize.width/10,
                ),
                Text(" "+title,style: TextStyle(fontSize: FontSize.xlarge,fontWeight: FontWeight.w700),),
              ],
            ),
            SizedBox(height: 10,),
            Hero(
              tag: index.toString(),
              child: AnimatedCircularChart(
                edgeStyle: SegmentEdgeStyle.round,
                duration: Duration.zero,
                initialChartData: data,
                key: _chartKey,
                size: Size(displaySize.width / 2, displaySize.width / 2),
                holeLabel: list[2][2].toString() + '%',
                labelStyle: TextStyle(
                  fontSize: FontSize.large,
                  fontWeight: FontWeight.w700,
                  color: theme.isDark ? Colors.white : Colors.black,
                ),
              ),
            ),
            Text("記録時間:"+values[0].toString()+"分"),
            Text("価値時間:"+values[1].toString()+"分"),
          ],
        ),
      ),
    );
  }
}
