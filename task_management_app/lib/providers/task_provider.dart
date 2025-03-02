import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/task_model.dart';
import '../services/task_service.dart'; // Import your service

class TaskProvider extends ChangeNotifier {
  final TaskService _taskService = TaskService(); // Create service instance

  String _urn = "";
  String _taskName = "";
  String _assignedBy = "Current User";
  String _assignedTo = "";
  DateTime? _commencementDate;
  DateTime? _dueDate;
  String _clientName = "";
  String _taskStatus = "Scheduled";
  String _description = "";

  // Public getters
  String get urn => _urn;
  String get taskName => _taskName;
  String get assignedBy => _assignedBy;
  String get assignedTo => _assignedTo;
  DateTime? get commencementDate => _commencementDate;
  DateTime? get dueDate => _dueDate;
  String get clientName => _clientName;
  String get taskStatus => _taskStatus;
  String get description => _description;

  // Setters
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

  void setDescription(String value) {
    _description = value;
    notifyListeners();
  }

  void setTaskStatus(String status) {
    _taskStatus = status;
    notifyListeners();
  }

  // Show FlutterToast Message
  void _showToast(String message, {bool isSuccess = true}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: isSuccess ? Colors.green : Colors.red,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  // **Submit Task using Service**
  Future<void> submitTask(BuildContext context) async {
    if (_taskName.isEmpty || _assignedTo.isEmpty || _commencementDate == null || _dueDate == null) {
      _showToast("Please fill all required fields", isSuccess: false);
      return;
    }

    // Create task data as a Map
    Map<String, dynamic> taskData = {
      "urn": _urn,
      "taskName": _taskName,
      "assignedBy": _assignedBy,
      "assignedTo": _assignedTo,
      "commencementDate": _commencementDate?.toIso8601String(),
      "dueDate": _dueDate?.toIso8601String(),
      "clientName": "SDK",
      "description": _description,
      "taskStatus": _taskStatus,
    };

    try {
      // **Call API Service**
      final response = await _taskService.createTask(taskData);

      if (response.isNotEmpty) {
        _showToast("Task created successfully");
        context.go('/'); // Navigate to home or task list page
      }
    } catch (e) {
      _showToast("Failed to create task: ${e.toString()}", isSuccess: false);
    }
  }
}
