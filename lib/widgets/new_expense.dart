import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter2_expense_app/models/expense.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onSubmittedNewItem});
  final Function(String, double, DateTime, ExpenseEnum) onSubmittedNewItem;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();

  DateTime? _selectedDate;
  ExpenseEnum? _selectedExpense;

  void _showDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);

    setState(() {
      _selectedDate = selectedDate;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  void _validateFormAndSubmit() {
    final inputValue = double.tryParse(_valueController.text);

    if (_titleController.text.trim().isEmpty ||
        _selectedDate == null ||
        _selectedExpense == null ||
        inputValue == null ||
        inputValue <= 0) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text('No field should be left empty!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            )
          ],
        ),
      );

      return;
    }

    _submitNewExpense();
  }

  void _submitNewExpense() {
    widget.onSubmittedNewItem(
      _titleController.text,
      double.parse(_valueController.text),
      _selectedDate!,
      _selectedExpense!,
    );
    print("Value from controller: ${_titleController.text}");
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        TextField(
          decoration: const InputDecoration(
            label: Text("Title"),
          ),
          controller: _titleController,
          maxLength: 50,
          keyboardType: TextInputType.text,
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  label: Text("Ammount"),
                  prefixText: "\$",
                ),
                maxLength: 50,
                controller: _valueController,
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              flex: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _selectedDate == null
                        ? 'No selected date'
                        : formatter.format(_selectedDate!).toString(),
                  ),
                  IconButton(
                    onPressed: _showDatePicker,
                    icon: const Icon(Icons.calendar_month),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 30,),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DropdownButton(
                items: ExpenseEnum.values
                    .map(
                      (item) => DropdownMenuItem(
                        value: item,
                        child: Text(
                          item.name.toUpperCase(),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    )
                    .toList(),
                value: _selectedExpense,
                onChanged: (value) {
                  setState(() {
                    _selectedExpense = value;
                    print('expense value now: $_selectedExpense');
                  });
                }),
            const SizedBox(
              width: 30,
            ),
            ElevatedButton(
              onPressed: () {
                _validateFormAndSubmit();
              },
              child: const Text('Save'),
            ),
            const SizedBox(
              width: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            )
          ],
        )
      ]),
    );
  }
}
