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
}
