//packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

//my files
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/ui/total_records/category_data.dart';
import 'package:zikanri/config.dart';

class TotalRecordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: displaySize.width,
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: displaySize.width / 5.5,
              vertical: displaySize.width / 35,
            ),
            child: _TopCardSwiper(),
          ),
          SizedBox(
            height: displaySize.width / 35,
          ),
          _CategoryGrid(),
          SizedBox(
            height: displaySize.width / 10,
          ),
        ],
      ),
    );
  }
}

class _TopCardSwiper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final swiperController = SwiperController();
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    Color color = (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: displaySize.width / 2.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: color,
            width: 3,
          ),
        ),
        child: Swiper(
          itemCount: 3,
          autoplay: true,
          autoplayDelay: 7000,
          duration: 800,
          controller: swiperController,
          itemBuilder: (context, index) {
            if (index % 3 == 0)
              return _TopAlignCard(
                dataTitle: '総記録時間',
                dataValue: userData.allTime.toString() + '分',
              );
            else if (index % 3 == 1)
              return _TopAlignCard(
                dataTitle: '総価値時間',
                dataValue: userData.allGood.toString() + '分',
              );
            return _TopAlignCard(
              dataTitle: '価値の割合',
              dataValue: userData.allPer.toString() + '%',
            );
          },
        ),
      ),
    );
  }
}

class _TopAlignCard extends StatelessWidget {
  _TopAlignCard({@required this.dataTitle, @required this.dataValue});
  final String dataTitle;
  final String dataValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.bubble_chart,
          size: displaySize.width / 10,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: displaySize.width / 70),
          child: Text(
            dataValue,
            style: TextStyle(
              fontSize: FontSize.xlarge,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Text(
          dataTitle,
          style: TextStyle(
            fontSize: FontSize.xsmall,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class _CategoryGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    final categories = userData.categories;
    final categoryView = userData.categoryView;
    return Wrap(
      children: List.generate(
        categories.length,
        (index) {
          if (categoryView[index]) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: displaySize.width / 35,
              ),
              child: _GridCard(index: index),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

class _GridCard extends StatelessWidget {
  const _GridCard({@required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: displaySize.width / 2.01,
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
                    builder: (context) => CategoryDataPage(
                      index: index,
                    ),
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _CategoryDataWidget(index: index),
                  Center(
                    child: _CircularChart(
                      index: index,
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

class _CategoryDataWidget extends StatelessWidget {
  _CategoryDataWidget({@required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context, listen: false);
    final list = userData.categories[index];
    int icon = list[0];
    String title = list[1];
    return Padding(
      padding: EdgeInsets.only(top: displaySize.width / 70),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            IconData(icon, fontFamily: 'MaterialIcons'),
            size: displaySize.width / 15,
          ),
          SizedBox(
            width: displaySize.width / 70,
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.end,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey,
                fontSize: FontSize.xsmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CircularChart extends StatelessWidget {
  _CircularChart({@required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    Color color = (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    Color subcolor = (theme.isDark) ? Colors.grey[700] : Colors.grey[300];
    //chart data
    final GlobalKey<AnimatedCircularChartState> _chartKey =
        new GlobalKey<AnimatedCircularChartState>();
    final list = userData.categories[index];
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
    //widget
    return Hero(
      tag: index.toString(),
      child: AnimatedCircularChart(
        edgeStyle: SegmentEdgeStyle.round,
        duration: Duration.zero,
        initialChartData: data,
        key: _chartKey,
        size: Size(
          displaySize.width / 4.5,
          displaySize.width / 4.5,
        ),
        holeLabel: list[2][2].toString() + '%',
        labelStyle: TextStyle(
          fontSize: FontSize.small,
          fontWeight: FontWeight.w700,
          color: theme.isDark ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
