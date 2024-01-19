import 'package:flutter/material.dart';
// import 'package:prog3_expense_tracker/expense.dart';
import 'package:prog3_expense_tracker/models/expense_structure.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  final void Function(ExpenseStructure expense) onAddExpense;
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountcontroller = TextEditingController();
  DateTime? selectedDate;

  Category selectedCategory = Category.food;

  void presentDatePicker() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 1, now.month, now.day),
      lastDate: now,
    );
    setState(() {
      selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountcontroller.text);
    final amountisInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountisInvalid ||
        selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text("Please Enter a valid title, amount and date."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text("Okay"),
            ),
          ],
        ),
      );
      return;
    }
    widget.onAddExpense(ExpenseStructure(
        title: _titleController.text,
        amount: enteredAmount,
        date: selectedDate!,
        category: selectedCategory));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardspace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: (ctx, constraints) {
        // print(constraints.minWidth);
        // print(constraints.maxWidth);
        // print(constraints.minHeight);
        // print(constraints.maxHeight);
        final width = constraints.maxWidth;
        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 40, 30, keyboardspace + 20),
              child: Column(
                children: [
                  const Text(
                    "Add Expense",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 130,
                    height: 15,
                    child: Container(
                      decoration: const BoxDecoration(
                        border: BorderDirectional(
                          top: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  if (width >= 600)
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _titleController,
                            maxLength: 50,
                            decoration: const InputDecoration(
                              label: Text("Title"),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _amountcontroller,
                            maxLength: 15,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              prefixText: '₹ ',
                              label: Text("Amount"),
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    TextField(
                      controller: _titleController,
                      maxLength: 50,
                      decoration: const InputDecoration(
                        label: Text("Title"),
                      ),
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (width >= 600)
                    Row(
                      children: [
                        DropdownButton(
                          value: selectedCategory,
                          items: Category.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(
                                    category.name.toUpperCase(),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (values) {
                            if (values == null) {
                              return;
                            }
                            setState(() {
                              selectedCategory = values;
                            });
                          },
                        ),
                        const Spacer(),
                        Text(selectedDate == null
                            ? 'No Date Selected'
                            : formatter.format(selectedDate!)),
                        IconButton(
                          onPressed: () {
                            presentDatePicker();
                          },
                          icon: const Icon(Icons.calendar_month),
                        )
                      ],
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _amountcontroller,
                            maxLength: 15,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              prefixText: '₹ ',
                              label: Text("Amount"),
                            ),
                          ),
                        ),
                        // SizedBox(width: 10),
                        const Spacer(),
                        Text(selectedDate == null
                            ? 'No Date Selected'
                            : formatter.format(selectedDate!)),
                        IconButton(
                          onPressed: () {
                            presentDatePicker();
                          },
                          icon: const Icon(Icons.calendar_month),
                        )
                      ],
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (width >= 600)
                    Row(
                      children: [
                        const Spacer(),
                        TextButton(
                          style: TextButton.styleFrom(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              // backgroundColor: Colors.deepPur
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                          onPressed: () {
                            _submitExpenseData();
                          },
                          child: const Text("Save Expense"),
                        ),
                        const Spacer()
                      ],
                    )
                  else
                    Row(
                      children: [
                        DropdownButton(
                          value: selectedCategory,
                          items: Category.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(
                                    category.name.toUpperCase(),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (values) {
                            if (values == null) {
                              return;
                            }
                            setState(() {
                              selectedCategory = values;
                            });
                          },
                        ),
                        const Spacer(),
                        TextButton(
                          style: TextButton.styleFrom(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              // backgroundColor: Colors.deepPur
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                          onPressed: () {
                            _submitExpenseData();
                          },
                          child: const Text("Save Expense"),
                        ),
                        const Spacer()
                      ],
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
