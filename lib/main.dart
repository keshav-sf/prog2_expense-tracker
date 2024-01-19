import 'package:flutter/material.dart';
import 'package:prog3_expense_tracker/expense.dart';

var kcolor = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);
var kdarkcolor = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() {
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark().copyWith(
          colorScheme: kdarkcolor,
          cardTheme: const CardTheme().copyWith(
            color: kdarkcolor.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kdarkcolor.primaryContainer,
              foregroundColor: kdarkcolor.onPrimaryContainer,
            ),
          ),
        ),
        theme: ThemeData().copyWith(
          colorScheme: kcolor,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kcolor.onPrimaryContainer,
            foregroundColor: kcolor.primaryContainer,
          ),

          cardTheme: const CardTheme().copyWith(
            color: kcolor.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          ),

          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: const Color.fromARGB(255, 234, 228, 243),
              // backgroundColor: kcolor.primaryContainer,
            ),
          ),

          //appbar
          //if want to use inside code e.g. Text("demo",style:Theme.of(context).textTheme.titleLarge)
          textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: kcolor.onSecondaryContainer,
                    fontSize: 20),
              ),
        ),
        home: const Expense()),
  );
}
