import 'package:flutter/material.dart';
import 'package:untitled2/data/data.dart';
import 'package:untitled2/helper/color_helper.dart';
import 'package:untitled2/models/category_model.dart';
import 'package:untitled2/models/expense_model.dart';
import 'package:untitled2/widget/bar_chart.dart';

import 'category_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    _buildCategory(Category category, double totalAmountSpent){
      return GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => CategoryScreen(category: category))
        ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          padding: EdgeInsets.all(20.0),
          height: 100.0,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 2),
                blurRadius: 6.0,
              )
            ]
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget> [
                  Text(category.name,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                  ),
                  Text('\$${(category.maxAmount - totalAmountSpent).toStringAsFixed(2)}/ \$${category.maxAmount}',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600
                  ),
                  )
                ],
              ),
              SizedBox(height: 10.0),
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  final double maxBarWidth = constraints.maxWidth;
                  final double percent = (category.maxAmount - totalAmountSpent) / category.maxAmount;
                  double barWidth = percent * maxBarWidth;

                  if (barWidth < 0) {
                    barWidth = 0;
                  }

                  return Stack(
                    children: <Widget>[
                      Container(
                        height: 20.0,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(15.0)
                        ),
                      ),
                      Container(
                        height: 20.0,
                        width: barWidth,
                        decoration: BoxDecoration(
                            color: getColor(context, percent),
                            borderRadius: BorderRadius.circular(15.0)
                        ),
                      )
                    ],
                  );
                }
              )
            ],
          ),
        ),
      );
    }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.greenAccent,
            forceElevated: true,
            pinned: true,
            //floating: true,
            expandedHeight: 100.0,
            leading: IconButton(
                onPressed: () {},
                icon: Icon(Icons.settings)),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Comrade Budget',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                iconSize: 25.0,
                onPressed: () {},
              )
            ],
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index){
                    if (index == 0) {
                      return Container(
                        margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                        decoration: BoxDecoration(
                            color: Colors.white12,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, 2),
                                blurRadius: 6.0,
                              )
                            ],
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: BarChart(weeklySpending),
                      );
                    }
                    else{
                      final Category category = categories[index -1];
                      double totalAmountSpent = 0;
                      category.expenses.forEach((Expense expense) {
                        totalAmountSpent += expense.cost;
                      });
                      return _buildCategory(category, totalAmountSpent);
                    }
                  },
                childCount: 1 + categories.length,
              ))
        ],
      ),
    );
  }
  }