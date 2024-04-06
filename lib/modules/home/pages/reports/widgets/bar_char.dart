import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onfly/modules/home/pages/reports/reports_controller.dart';
import 'package:onfly/shared/theme/colors.dart';
import 'package:onfly/shared/utils/currency.dart';

class BarChartSample1 extends StatefulWidget {
  final List<ExpenseByDay> listExpenseByDay;
  BarChartSample1({
    super.key,
    required this.listExpenseByDay,
  });

  final Color barBackgroundColor = DefaultColors().subText;
  final Color barColor = DefaultColors().primary;
  final Color touchedBarColor = DefaultColors().primaryDark;

  @override
  State<StatefulWidget> createState() => BarChartSample1State();
}

class BarChartSample1State extends State<BarChartSample1> {
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: BarChart(
                      mainBarData(),
                      swapAnimationDuration: animDuration,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double findExpenseWithHighestValue() {
    ExpenseByDay highestExpense = widget.listExpenseByDay.first;
    for (var expense in widget.listExpenseByDay) {
      if (expense.value > highestExpense.value) {
        highestExpense = expense;
      }
    }

    return highestExpense.value;
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    barColor ??= widget.barColor;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? widget.touchedBarColor : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(
                  color: DefaultColors().primaryDark,
                  width: 5,
                )
              : BorderSide(
                  color: DefaultColors().primaryDark,
                  width: 0,
                ),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: findExpenseWithHighestValue(),
            color: widget.barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(widget.listExpenseByDay.length, (i) {
        return makeGroupData(i, widget.listExpenseByDay[i].value, isTouched: i == touchedIndex);
      });

  BarChartData mainBarData() {
    return BarChartData(
      barGroups: showingGroups(),
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (_) => Colors.blueGrey,
          tooltipHorizontalAlignment: FLHorizontalAlignment.right,
          tooltipMargin: -10,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String day = DateFormat('dd/MM/yyyy', 'pt_BR').format(widget.listExpenseByDay[groupIndex].date);
            return BarTooltipItem(
              '$day\n',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: Currency().formatMoney(value: rod.toY - 1, currency: 'BRL'),
                  style: const TextStyle(
                    color: Colors.white, //widget.touchedBarColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions || barTouchResponse == null || barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
            interval: 6,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      gridData: const FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );

    Widget text = Text(DateFormat('dd/MM', 'pt_BR').format(widget.listExpenseByDay[value.toInt()].date), style: style);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }
}
