import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
const uuid = Uuid();

final formatter = DateFormat.yMd();

enum ExpenseEnum {
   life, food, leisure, work,
}

const categoryIcon = {
  ExpenseEnum.food: Icons.lunch_dining,
  ExpenseEnum.leisure: Icons.catching_pokemon,
  ExpenseEnum.life: Icons.headphones,
  ExpenseEnum.work: Icons.work,
};

class Expense {
  Expense({
    required this.title,
    required this.ammount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double ammount;
  final DateTime date;
  final ExpenseEnum category;

  String get formattedDate {
    return formatter.format(date);
  }
}


