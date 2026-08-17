import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Expense {
  String id;
  Category category;
  String name;
  double amount;
  Expense(this.id, this.category, this.name, this.amount);
}

class Category {
  String id;
  String name;

  Category(this.id, this.name);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  double getCategoryTotal(Category category, List<Expense> expenses) {
    return expenses
        .where((expense) => expense.category.id == category.id)
        .fold(0, (sum, expense) => sum + expense.amount);
  }

  @override
  Widget build(BuildContext context) {
    Category category1 = Category("1", "Food");
    Category category2 = Category("2", "Transport");
    Category category3 = Category("3", "School");

    List<Category> categories = [category1, category2, category3];

    Expense mockExpense1 = Expense("1", category1, "Lunch", 60.52);
    Expense mockExpense2 = Expense("2", category2, "Fare", 120.334);
    Expense mockExpense3 = Expense("3", category3, "Project", 130);
    Expense mockExpense4 = Expense("4", category1, "Snack", 45);

    List<Expense> expenses = [
      mockExpense1,
      mockExpense2,
      mockExpense3,
      mockExpense4,
    ];
    double totalSpent = expenses.fold(
      0,
      (sum, expense) => sum + expense.amount,
    );

    String formattedPrice = totalSpent.toStringAsFixed(2);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("Expense Tracker")),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              ListTile(
                title: Text("Total Spent:"),
                trailing: Text("₱$formattedPrice"),
              ),

              SizedBox(
                height: 100,

                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 115,
                      child: Card(
                        child: ListTile(
                          title: Text(categories[index].name),
                          subtitle: Text(
                            "₱${getCategoryTotal(categories[index], expenses).toStringAsFixed(2)}",
                          ),
                        ),
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
                    return Card(
                      child: ListTile(
                        title: Text(expenses[index].name),
                        subtitle: Text(expenses[index].category.name),
                        trailing: Text(
                          "₱${expenses[index].amount.toStringAsFixed(2)}",
                        ),
                      ),
                    );
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
