import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:zikanri/previous_records/category_data.dart';

import '../data.dart';

class PRPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    return SizedBox(
      width: displaySize.width,
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: displaySize.width / 5.5, vertical: 10),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                height: displaySize.width / 2.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: theme.isDark
                        ? theme.themeColors[0]
                        : theme.themeColors[1],
                    width: 3,
                  ),
                ),
                child: Swiper(
                  itemCount: 3,
                  autoplay: true,
                  autoplayDelay: 10000,
                  duration: 1000,
                  controller: SwiperController(),
                  itemBuilder: (context, index) {
                    if (index % 3 == 0)
                      return topCard(
                          '総記録時間', userData.allTime.toString() + '分');
                    else if (index % 3 == 1)
                      return topCard(
                          '総価値時間', userData.allGood.toString() + '分');
                    return topCard('価値の割合', userData.allPer.toString() + '%');
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Wrap(
            children: [
              for (int i = 0; i < userData.categories.length; i += 1)
                (userData.categoryView[i])
                    ? Padding(
                        padding: const EdgeInsets.only(
                          bottom: 10.0,
                        ),
                        child: GridCard(i),
                      )
                    : Container(),
            ],
          ),
          SizedBox(
            height: displaySize.width / 10,
          ),
        ],
      ),
    );
  }

  Widget topCard(title, value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.bubble_chart,
          size: displaySize.width / 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(
            value,
            style: TextStyle(
                fontSize: FontSize.xlarge, fontWeight: FontWeight.w700),
          ),
        ),
        Text(
          title,
          style: TextStyle(fontSize: FontSize.xsmall, color: Colors.grey),
        ),
      ],
    );
  }
}

class GridCard extends StatelessWidget {
  final int index;
  GridCard(this.index);
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
    return SizedBox(
      width: displaySize.width / 2,
      child: Center(
        child: SizedBox(
          height: displaySize.width / 2.8,
          width: displaySize.width / 2.2,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CategoryDataPage(index)));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(
                          IconData(icon, fontFamily: "MaterialIcons"),
                          size: displaySize.width / 15,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Text(
                            title,
                            textAlign: TextAlign.end,
                            softWrap: false,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: FontSize.xsmall,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Hero(
                      tag: index.toString(),
                      child: AnimatedCircularChart(
                        edgeStyle: SegmentEdgeStyle.round,
                        duration: Duration.zero,
                        initialChartData: data,
                        key: _chartKey,
                        size: Size(
                            displaySize.width / 4.5, displaySize.width / 4.5),
                        holeLabel: list[2][2].toString() + '%',
                        labelStyle: TextStyle(
                          fontSize: FontSize.small,
                          fontWeight: FontWeight.w700,
                          color: theme.isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
