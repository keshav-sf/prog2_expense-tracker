import 'package:flutter/material.dart';
import 'package:prog3_expense_tracker/models/expense_structure.dart';
import 'package:prog3_expense_tracker/widget/expenses_list/expense_items.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(
      {super.key, required this.expenses, required this.onRemovedExpense});

  final List<ExpenseStructure> expenses;
  final void Function(ExpenseStructure expense) onRemovedExpense;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expenses[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.8),
          margin: const EdgeInsets.symmetric(
              horizontal: 8), //set background color for swip delete
        ),
        onDismissed: (cxt) {
          onRemovedExpense(expenses[index]);
        },
        child: ExpenseItems(
          expenses[index],
        ),
      ),
    );
  }
}
