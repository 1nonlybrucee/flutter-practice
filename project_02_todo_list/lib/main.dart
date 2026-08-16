import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class Task {
  String id;
  String title;
  bool completed;

  Task({required this.id, required this.title, required this.completed});
}

class _MyHomePageState extends State<MyHomePage> {
  List<Task> tasks = [];
  final uuid = Uuid();

  final TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Todo List")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Enter your task",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.trim().isEmpty) {
                  return;
                }
                setState(() {
                  tasks.add(
                    Task(
                      id: uuid.v4(),
                      title: nameController.text,
                      completed: false,
                    ),
                  );
                });
                nameController.clear();
              },
              child: Text("Submit"),
            ),

            if (tasks.isNotEmpty)
              Text(
                "${tasks.where((task) => task.completed).length} / ${tasks.length} tasks completed",
              ),

            if (tasks.isEmpty)
              const Expanded(
                child: Center(
                  child: Text("No tasks yet", style: TextStyle(fontSize: 10)),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return Card(
                      child: ListTile(
                        leading: Checkbox(
                          value: task.completed,
                          onChanged: (value) {
                            setState(() {
                              task.completed = value!;
                            });
                          },
                        ),
                        title: Text(
                          task.title,
                          style: TextStyle(
                            decoration: task.completed
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            color: task.completed ? Colors.grey : Colors.black,
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              tasks.removeAt(index);
                            });
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
