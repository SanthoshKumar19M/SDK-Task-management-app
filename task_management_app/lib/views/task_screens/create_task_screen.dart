import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../core/theme.dart';
import '../../providers/task_provider.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/side_nav_bar.dart';
import '../../widgets/header.dart';

class CreateTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    String userInitial = "S"; // Replace with dynamic value

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Row(
        children: [
          SideNavBar(isHomeScreen: false),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(breadCrums: "Create task", userInitial: userInitial),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  label: "Task Number",
                                  initialValue: "Task number will generate automatically",
                                  enabled: false,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: CustomTextField(
                                  label: "Task Name",
                                  onChanged: taskProvider.setTaskName,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  label: "Assigned By",
                                  initialValue: taskProvider.assignedBy,
                                  enabled: false,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: CustomTextField(
                                  label: "Assigned To",
                                  onChanged: taskProvider.setAssignedTo,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: DatePickerField(
                                  label: "Commencement Date",
                                  selectedDate: taskProvider.commencementDate,
                                  onDateSelected: taskProvider.setCommencementDate,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: DatePickerField(
                                  label: "Due Date",
                                  selectedDate: taskProvider.dueDate,
                                  onDateSelected: taskProvider.setDueDate,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            label: "Description",
                            onChanged: taskProvider.setDescription,
                            maxLines: 3,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Client Details",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          _buildClientDetailsTable(),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_validateInputs(taskProvider)) {
                            taskProvider.submitTask(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: AppTheme.primaryColor,
                        ),
                        child: const Text("Submit"),
                      ),
                      const SizedBox(width: 10),
                      OutlinedButton(
                        onPressed: () => context.go('/'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppTheme.primaryColor,
                          side: BorderSide(color: AppTheme.primaryColor),
                        ),
                        child: const Text("Cancel"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _validateInputs(TaskProvider provider) {
    if (provider.taskName.isEmpty || provider.assignedTo.isEmpty || provider.commencementDate == null || provider.dueDate == null) {
      Fluttertoast.showToast(
        msg: "Please fill all required fields",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        webPosition: "center",
      );
      return false;
    }
    return true;
  }

  Widget _buildClientDetailsTable() {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Name')),
        DataColumn(label: Text('Designation')),
        DataColumn(label: Text('Email')),
      ],
      rows: const [
        DataRow(cells: [
          DataCell(Text("John Doe")),
          DataCell(Text("Manager")),
          DataCell(Text("john@example.com")),
        ]),
        DataRow(cells: [
          DataCell(Text("Jane Smith")),
          DataCell(Text("Director")),
          DataCell(Text("jane@example.com")),
        ]),
      ],
    );
  }
}

/// Fixed Date Picker Field
class DatePickerField extends StatefulWidget {
  final String label;
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;

  const DatePickerField({
    Key? key,
    required this.label,
    this.selectedDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  _DatePickerFieldState createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.selectedDate != null ? widget.selectedDate!.toString().split(' ')[0] : '',
    );
  }

  @override
  void didUpdateWidget(covariant DatePickerField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDate != oldWidget.selectedDate) {
      _controller.text = widget.selectedDate != null ? widget.selectedDate!.toString().split(' ')[0] : '';
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: widget.selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      widget.onDateSelected(picked);
      setState(() {
        _controller.text = picked.toString().split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: widget.label,
            suffixIcon: const Icon(Icons.calendar_today),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
