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
    });
  }

  @override
  Widget build(BuildContext context) {
    groupedTrasaction;
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: groupedTrasaction.map((tr) {
          return ChartBar(
              label: tr["day"] as String,
              value: tr["value"] as double,
              percentage: 0);
        }).toList(),
      ),
    );
  }
}
