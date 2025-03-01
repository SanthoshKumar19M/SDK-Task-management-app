import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/task_provider.dart';
import '../../widgets/custom_text_field.dart';

class CreateTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Create Task")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Task Name & Task Number in One Row
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      label: "Task Name",
                      onChanged: taskProvider.setTaskName,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomTextField(
                      label: "Task Number",
                      initialValue: taskProvider.urn,
                      enabled: false,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Assigned By & Assigned To in One Row
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

              // Commencement Date & Due Date in One Row
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
                label: "Client Name",
                onChanged: taskProvider.setClientName,
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
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  taskProvider.submitTask();
                },
                child: const Text("Submit"),
              ),
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the client details table (Placeholder data)
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

/// Custom Date Picker Field Widget
class DatePickerField extends StatelessWidget {
  final String label;
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;

  const DatePickerField({required this.label, this.selectedDate, required this.onDateSelected});

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: TextFormField(
          decoration: InputDecoration(
            labelText: label,
            suffixIcon: const Icon(Icons.calendar_today),
          ),
          controller: TextEditingController(
            text: selectedDate != null ? selectedDate!.toString().split(' ')[0] : '',
          ),
        ),
      ),
    );
  }
}
