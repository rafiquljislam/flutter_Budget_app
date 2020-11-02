import 'package:budgetappp/helpers/color_helper.dart';
import 'package:budgetappp/models/expense_model.dart';
import 'package:budgetappp/widgets/radialPanter.dart';

import '../models/category_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryScreens extends StatefulWidget {
  final Category category;

  const CategoryScreens(this.category);
  @override
  _CategoryScreensState createState() => _CategoryScreensState();
}

class _CategoryScreensState extends State<CategoryScreens> {
  _buildExpancire() {
    List<Widget> expenseList = [];
    widget.category.expenses.forEach(
      (Expense expense) {
        expenseList.add(
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            height: 80,
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
            child: Padding(
              padding: EdgeInsets.all(30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    expense.name,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "-\$ ${expense.cost.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    return Column(children: expenseList);
  }

  @override
  Widget build(BuildContext context) {
    double totalAmountsSpan = 0;
    widget.category.expenses.forEach((Expense expense) {
      totalAmountsSpan += expense.cost;
    });
    final double amountLeft = widget.category.maxAmount - totalAmountsSpan;
    final double percent = amountLeft / widget.category.maxAmount;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
        actions: [
          IconButton(
            iconSize: 30,
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.all(20.0),
              height: 250.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 2),
                    blurRadius: 6.0,
                  )
                ],
              ),
              child: CustomPaint(
                foregroundPainter: RadialPainter(
                  bgColor: Colors.grey[200],
                  lineColor: getColor(context, percent),
                  percent: percent,
                  width: 15.0,
                ),
                child: Center(
                  child: Text(
                    "\$ ${amountLeft.toStringAsFixed(2)} / \$ ${widget.category.maxAmount}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ),
            _buildExpancire(),
          ],
        ),
      ),
    );
  }
}
