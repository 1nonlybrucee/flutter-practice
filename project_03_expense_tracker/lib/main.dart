import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Expense {
  String id;
  Category category;
  String name;
  Expense(this.id, this.category, this.name);
}

class Category {
  String id;
  String name;

  Category(this.id, this.name);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    double totalSpent = 0.00;
    Category category1 = Category("1", "Food");
    Category category2 = Category("2", "Transport");
    Category category3 = Category("3", "School");

    List<Category> categories = [category1, category2, category3];

    Expense mockExpense1 = Expense("1", category1, "lunch");
    Expense mockExpense2 = Expense("2", category2, "fare");
    Expense mockExpense3 = Expense("3", category3, "project");

    List<Expense> expenses = [mockExpense1, mockExpense2, mockExpense3];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("Expense Tracker")),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text("Total Spent \n₱$totalSpent"),

              SizedBox(
                height: 100,

                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 115,
                      child: Card(
                        child: Center(child: Text(categories[index].name)),
                      ),
                    );
                  },
                ),
              ),
              Text("Recent Expenses"),

              Expanded(
                child: ListView.builder(
                  itemCount: expenses.length,
                  itemBuilder: (context, index) {
                    return Card(child: Text(expenses[index].name));
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Text("+"),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
