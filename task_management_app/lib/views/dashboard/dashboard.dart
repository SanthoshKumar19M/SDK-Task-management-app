import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme.dart';
import '../../widgets/side_nav_bar.dart';
import '../../services/task_service.dart';
import '../../widgets/header.dart';
import '../../utils/date_formatter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TaskService _taskService = TaskService();
  List<dynamic> tasks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    try {
      final fetchedTasks = await _taskService.getAllTasks();
      setState(() {
        tasks = fetchedTasks;
        isLoading = false;
      });
      // print(tasks);
    } catch (error) {
      print("Error fetching tasks: $error");
      setState(() {
        isLoading = false;
      });
    }
  }

  void _moveToWithheldTasks(dynamic task) {
    setState(() {
      tasks.remove(task);
      Fluttertoast.showToast(
        msg: "Task moved to With-held Tasks",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // final String routePath = GoRouterState.of(context).uri.toString();
    // List<String> pathSegments = routePath.split('/').where((e) => e.isNotEmpty).toList();
    List<String> pathSegments = GoRouterState.of(context).uri.toString().split('/').where((s) => s.isNotEmpty).toList();
    String userInitial = "S"; // Replace with dynamic value
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Row(
        children: [
          // Sidebar
          SideNavBar(isHomeScreen: true),
          // Main Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header content
                Header(pathSegments: pathSegments, userInitial: userInitial),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        icon: Icon(Icons.add, color: Colors.white),
                        label: Text("Add Task", style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // Button color
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        ),
                        onPressed: () {
                          context.go('/create-task'); // Navigate to Add Task screen
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: isLoading
                        ? Center(child: CircularProgressIndicator())
                        : tasks.isEmpty
                            ? Center(child: Text("No tasks available"))
                            : SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                    border: TableBorder.all(color: Colors.grey.shade300),
                                    headingRowColor: MaterialStateColor.resolveWith((states) => Colors.blue.shade100),
                                    columns: const [
                                      DataColumn(label: Text("URN", style: TextStyle(fontWeight: FontWeight.bold))),
                                      DataColumn(label: Text("Task Name", style: TextStyle(fontWeight: FontWeight.bold))),
                                      DataColumn(label: Text("Assigned By", style: TextStyle(fontWeight: FontWeight.bold))),
                                      DataColumn(label: Text("Assigned To", style: TextStyle(fontWeight: FontWeight.bold))),
                                      DataColumn(label: Text("Commencement Date", style: TextStyle(fontWeight: FontWeight.bold))),
                                      DataColumn(label: Text("Due Date", style: TextStyle(fontWeight: FontWeight.bold))),
                                      DataColumn(label: Text("Client Name", style: TextStyle(fontWeight: FontWeight.bold))),
                                      DataColumn(label: Text("Status", style: TextStyle(fontWeight: FontWeight.bold))),
                                      DataColumn(label: Text("Actions", style: TextStyle(fontWeight: FontWeight.bold))),
                                    ],
                                    rows: tasks.map((task) {
                                      return DataRow(cells: [
                                        DataCell(Text(task['urn'].toString())),
                                        DataCell(Text(task['taskName'] ?? "No Title")),
                                        DataCell(Text(task['assignedBy'] ?? "Unknown")),
                                        DataCell(Text(task['assignedTo'] ?? "Unknown")),
                                        DataCell(Text(formatDate(task['commencementDate']))),
                                        DataCell(Text(formatDate(task['dueDate']))),
                                        DataCell(Text(task['clientName'] ?? "Unknown")),
                                        DataCell(Text(task['taskStatus'] ?? "Scheduled")),
                                        // DataCell(
                                        //   Icon(
                                        //     task['status'] ? Icons.check_circle : Icons.pending,
                                        //     color: task['taskStatus'] ? Colors.green : Colors.orange,
                                        //   ),
                                        // ),
                                        DataCell(Row(
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.play_arrow, color: Colors.green),
                                              tooltip: "Start Task",
                                              onPressed: () {
                                                context.go('/task-commencement/${task['_id']}');
                                              },
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.edit, color: Colors.blue),
                                              tooltip: "Edit Task",
                                              onPressed: () {
                                                context.go('/edit-task/${task['_id']}');
                                              },
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.delete, color: Colors.red),
                                              tooltip: "Delete Task",
                                              onPressed: () => _moveToWithheldTasks(task),
                                            ),
                                          ],
                                        )),
                                      ]);
                                    }).toList(),
                                  ),
                                ),
                              ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
