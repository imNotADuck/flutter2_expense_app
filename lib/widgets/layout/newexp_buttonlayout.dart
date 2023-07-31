import 'package:flutter/material.dart';

class NewExpButtonLayouts extends StatelessWidget {
  const NewExpButtonLayouts({super.key, required this.onSaveBtnPressed});

  final Function onSaveBtnPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const SizedBox(
          width: 30,
        ),
        ElevatedButton(
          onPressed: () {
            onSaveBtnPressed();
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
    );
  }
}
