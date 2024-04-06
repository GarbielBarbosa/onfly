import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:onfly/modules/home/pages/reports/reports_controller.dart';

class PieChartCategory extends StatefulWidget {
  const PieChartCategory({
    super.key,
    required this.expenseByCategory,
  });

  final List<ExpenseByCategory> expenseByCategory;

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartCategory> {
  int touchedIndex = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Color> blueVariations = generateBlueVariations(widget.expenseByCategory.length);

    List<Widget> list = List.generate(widget.expenseByCategory.length, (i) {
      return Indicator(
        color: blueVariations[i],
        text: widget.expenseByCategory[i].category,
        isSquare: true,
      );
    });
    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions || pieTouchResponse == null || pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: List.generate(widget.expenseByCategory.length, (i) {
                    final isTouched = i == touchedIndex;
                    final fontSize = isTouched ? 25.0 : 16.0;
                    final radius = isTouched ? 60.0 : 50.0;
                    const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

                    return PieChartSectionData(
                      color: blueVariations[i],
                      value: widget.expenseByCategory[i].value,
                      title: '${widget.expenseByCategory[i].percentage.toStringAsFixed(2)}%',
                      radius: radius,
                      titleStyle: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        shadows: shadows,
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: list,
          ),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }
}

List<Color> generateBlueVariations(int numberOfVariations) {
  const Color startColor = Color.fromARGB(255, 0, 74, 186);
  const Color endColor = Color.fromARGB(255, 156, 227, 255);
  List<Color> variations = [];

  int startRed = startColor.red;
  int startGreen = startColor.green;
  int startBlue = startColor.blue;

  int endRed = endColor.red;
  int endGreen = endColor.green;
  int endBlue = endColor.blue;

  int redDifference = endRed - startRed;
  int greenDifference = endGreen - startGreen;
  int blueDifference = endBlue - startBlue;

  double redIncrement = redDifference / (numberOfVariations - 1);
  double greenIncrement = greenDifference / (numberOfVariations - 1);
  double blueIncrement = blueDifference / (numberOfVariations - 1);

  // Gera as variações de cor
  for (int i = 0; i < numberOfVariations; i++) {
    int r = (startRed + (redIncrement * i)).round();
    int g = (startGreen + (greenIncrement * i)).round();
    int b = (startBlue + (blueIncrement * i)).round();
    variations.add(Color.fromRGBO(r, g, b, 1.0));
  }

  return variations;
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}
