import 'package:flutter/material.dart';
import 'package:flutter_expenses/components/chart_bar.dart';
import 'package:intl/intl.dart';
import 'package:flutter_expenses/models/transaction.dart';

class Chart extends StatelessWidget {
  const Chart(this.recentTrasaction, {super.key});

  final List<Transaction> recentTrasaction;

  List<Map<String, Object>> get groupedTrasaction {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0.0;

      for (var i = 0; i < recentTrasaction.length; i++) {
        bool sameDay = recentTrasaction[i].date.day == weekDay.day;
        bool sameMonth = recentTrasaction[i].date.month == weekDay.month;
        bool sameYear = recentTrasaction[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += recentTrasaction[i].value;
        }
      }

      return {
        "day": DateFormat.E().format(weekDay)[0],
        "value": totalSum,
      };
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTrasaction.fold(0.0, (sum, tr) {
      return sum + (tr["value"] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTrasaction.map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  label: tr["day"] as String,
                  value: tr["value"] as double,
                  percentage: _weekTotalValue == 0 ? 0 :  (tr["value"] as double) / _weekTotalValue),
            );
          }).toList(),
        ),
      ),
    );
  }
}
