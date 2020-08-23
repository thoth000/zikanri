//packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

//my files
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/config.dart';

class CategoryDataPage extends StatelessWidget {
  const CategoryDataPage(this.index);
  final int index;

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
        padding: EdgeInsets.symmetric(horizontal: displaySize.width / 20),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Icon(
                  IconData(icon, fontFamily: 'MaterialIcons'),
                  size: displaySize.width / 10,
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    title,
                    style: TextStyle(
                        fontSize: FontSize.xlarge, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
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
            const SizedBox(
              height: 10,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: displaySize.width / 3.5,
                    width: displaySize.width / 2.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          values[0].toString() + '分',
                          softWrap: false,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            fontSize: FontSize.large,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          '記録時間',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: FontSize.xxsmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 0.5,
                    height: displaySize.width / 3.5 - 10,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: displaySize.width / 3.5,
                    width: displaySize.width / 2.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          values[1].toString() + '分',
                          softWrap: false,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            fontSize: FontSize.large,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          '価値時間',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: FontSize.xxsmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
