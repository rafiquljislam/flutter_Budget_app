import 'package:budgetappp/data/data.dart';
import 'package:budgetappp/helpers/color_helper.dart';
import 'package:budgetappp/models/category_model.dart';
import 'package:budgetappp/models/expense_model.dart';
import 'package:budgetappp/screens/CategoryScreens.dart';
import 'package:budgetappp/widgets/bar__chart.dart';
import 'package:flutter/material.dart';

class HomeScreens extends StatefulWidget {
  @override
  _HomeScreensState createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  _buildCategory(Category category, double totalAmountSpent) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => CategoryScreens(category),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.all(20.0),
        height: 100.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  category.name,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "\$${(category.maxAmount - totalAmountSpent).toStringAsFixed(2)}/ \$ ${category.maxAmount..toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            LayoutBuilder(builder: (ctx, constraints) {
              final double maxBarWidth = constraints.maxWidth;
              final double percent =
                  (category.maxAmount - totalAmountSpent) / category.maxAmount;
              double barWidth = percent * maxBarWidth;
              if (barWidth < 0) {
                barWidth = 0;
              }
              return Stack(
                children: [
                  Container(
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  Container(
                    height: 20.0,
                    width: barWidth,
                    decoration: BoxDecoration(
                      color: getColor(context, percent),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  )
                ],
              );
            })
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
            forceElevated: true,
            floating: true,
            // pinned: true,
            expandedHeight: 100,
            leading: IconButton(
              onPressed: () {},
              icon: Icon(Icons.settings),
              iconSize: 30,
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text("Simple Budget"),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                iconSize: 30,
                icon: Icon(Icons.add),
              )
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int i) {
                if (i == 0) {
                  return Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 2),
                          blurRadius: 6.0,
                        )
                      ],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: BarChart(weeklySpending),
                  );
                } else {
                  final Category category = categories[i - 1];
                  double totalAmountSpent = 0;
                  category.expenses.forEach((Expense expense) {
                    totalAmountSpent += expense.cost;
                  });
                  return _buildCategory(category, totalAmountSpent);
                }
              },
              childCount: 1 + categories.length,
            ),
          )
        ],
      ),
    );
  }
}
