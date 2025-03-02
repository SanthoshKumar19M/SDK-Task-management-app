import 'dart:convert';
import 'package:http/http.dart' as http;

class TaskService {
  final String baseUrl = "http://localhost:5000"; // Update with actual API URL

  // Fetch all tasks
  Future<List<dynamic>> getAllTasks() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/tasks'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        // Check if 'tasks' key exists and is a list
        if (responseData.containsKey('tasks') && responseData['tasks'] is List) {
          return responseData['tasks'];
        } else {
          throw Exception("Invalid response format");
        }
      } else {
        throw Exception('Failed to load tasks');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Map<String, dynamic>> createTask(Map<String, dynamic> taskData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/tasks'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(taskData),
      );

      if (response.statusCode == 201) {
        return json.decode(response.body); // Return the created task response
      } else {
        throw Exception('Failed to create task');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Map<String, dynamic>> editTask(String taskId, Map<String, dynamic> updatedTaskData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/tasks/$taskId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(updatedTaskData),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to update task');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Delete a task
  Future<void> deleteTask(String taskId) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/tasks/$taskId'),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete task');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
