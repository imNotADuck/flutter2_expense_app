import 'package:flutter/material.dart';
import 'package:flutter2_expense_app/widgets/chart/chart.dart';
import 'package:flutter2_expense_app/widgets/expense_list.dart';
import 'package:flutter2_expense_app/widgets/new_expense.dart';

import '../models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  void _openAddExpenseItem() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NewExpense(
        onSubmittedNewItem: _addNewExpenseItem,
      ),
    );
  }

  void _addNewExpenseItem(
    String title,
    double ammount,
    DateTime date,
    ExpenseEnum category,
  ) {
    setState(() {
      _expenseList.add(
        Expense(
          title: title,
          ammount: ammount,
          date: date,
          category: category,
        ),
      );
    });
  }

  void _onRemoveExpenseItem(Expense item) {
    final expenseIndex = _expenseList.indexOf(item);
    setState(() {
      _expenseList.remove(item);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense removed'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _expenseList.insert(expenseIndex, item);
            });
          },
        ),
      ),
    );
  }

  final List<Expense> _expenseList = [
    Expense(
      title: 'burger',
      ammount: 30,
      date: DateTime.now(),
      category: ExpenseEnum.food,
    ),
    Expense(
      title: 'haircut',
      ammount: 30,
      date: DateTime.now(),
      category: ExpenseEnum.life,
    ),
    Expense(
      title: 'udemycourse',
      ammount: 30,
      date: DateTime.now(),
      category: ExpenseEnum.work,
    ),
    Expense(
      title: 'games',
      ammount: 30,
      date: DateTime.now(),
      category: ExpenseEnum.leisure,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Widget placeHolder = const Center(
      child: Text('Start adding some...'),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter 2 expense app'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseItem,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: _expenseList.isEmpty
          ? placeHolder
          : Column(
              children: [
                Chart(
                  expenses: _expenseList,
                ),
                Expanded(
                  child: ExpenseList(
                    expenses: _expenseList,
                    onRemoveExpense: _onRemoveExpenseItem,
                  ),
                ),
              ],
            ),
    );
  }
}
