import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  String _urn = "";
  String _taskName = "";
  String _assignedBy = "Current User";
  String _assignedTo = "";
  DateTime? _commencementDate;
  DateTime? _dueDate;
  String _clientName = "";
  String _taskStatus = "Scheduled";

  // Public getters for accessing private fields
  String get urn => _urn;
  String get assignedBy => _assignedBy;
  DateTime? get commencementDate => _commencementDate;
  DateTime? get dueDate => _dueDate;
  String get clientName => _clientName;
  String get taskStatus => _taskStatus;

  // Setters to update values and notify listeners
  void setTaskName(String value) {
    _taskName = value;
    notifyListeners();
  }

  void setAssignedTo(String value) {
    _assignedTo = value;
    notifyListeners();
  }

  void setCommencementDate(DateTime date) {
    _commencementDate = date;
    notifyListeners();
  }

  void setDueDate(DateTime date) {
    _dueDate = date;
    notifyListeners();
  }

  void setClientName(String value) {
    _clientName = value;
    notifyListeners();
  }

  void setTaskStatus(String status) {
    _taskStatus = status;
    notifyListeners();
  }

  void submitTask() {
    if (_commencementDate == null || _dueDate == null) {
      debugPrint("Error: Commencement Date and Due Date cannot be null.");
      return;
    }

    Task newTask = Task(
      urn: _urn,
      taskName: _taskName,
      assignedBy: _assignedBy,
      assignedTo: _assignedTo,
      commencementDate: _commencementDate!,
      dueDate: _dueDate!,
      clientName: _clientName,
      taskStatus: _taskStatus,
    );

    debugPrint("Task Submitted: ${newTask.toJson()}");
  }
}
