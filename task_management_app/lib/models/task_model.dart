class Task {
  final String urn;
  final String taskName;
  final String assignedBy;
  final String assignedTo;
  final DateTime commencementDate;
  final DateTime dueDate;
  final String clientName;
  final bool status;
  final String taskStatus;

  Task({
    required this.urn,
    required this.taskName,
    required this.assignedBy,
    required this.assignedTo,
    required this.commencementDate,
    required this.dueDate,
    required this.clientName,
    this.status = true,
    this.taskStatus = "Scheduled",
  });

  Map<String, dynamic> toJson() {
    return {
      // "urn": urn,
      "taskName": taskName,
      "assignedBy": assignedBy,
      "assignedTo": assignedTo,
      "commencementDate": commencementDate.toIso8601String(),
      "dueDate": dueDate.toIso8601String(),
      "clientName": clientName,
      "status": status,
      "taskStatus": taskStatus,
    };
  }
}
