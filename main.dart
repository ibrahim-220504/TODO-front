import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple ToDo App',
      debugShowCheckedModeBanner: false,
      home: ToDoPage(),
    );
  }
}

class ToDoPage extends StatefulWidget {
  @override
  _ToDoPageState createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  TextEditingController taskController = TextEditingController();
  List<String> tasks = [];

  void addTask() {
    String text = taskController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        tasks.add(text);
        taskController.clear();
      });
    }
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do App'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskController,
                    decoration: const InputDecoration(
                      hintText: 'Enter a task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: addTask,
                  icon: const Icon(Icons.add),
                  label: const Text('Add'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: tasks.isEmpty
                  ? Center(
                      child: Text(
                        'No tasks yet!',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                    )
                  : ListView.separated(
                      itemCount: tasks.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: Key(tasks[index]),
                          direction: DismissDirection.startToEnd,
                          onDismissed: (_) => deleteTask(index),
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 20),
                            child: const Icon(Icons.delete, color: Colors.white),
                          ),
                          child: Card(
                            child: ListTile(
                              title: Text(tasks[index]),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => deleteTask(index),
                              ),
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
