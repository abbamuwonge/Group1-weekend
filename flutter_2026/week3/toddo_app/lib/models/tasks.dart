class Task {
  String title;
  bool isDone;
  // Priority is persisted, while older saved tasks default to not important.
  bool isImportant;

  Task(this.title, {this.isDone = false, this.isImportant = false});

  Map<String, dynamic> toJson() => {
    'title': title,
    'isDone': isDone,
    'isImportant': isImportant,
  };

  factory Task.fromJson(Map<String, dynamic> json) =>
      Task(
        json['title'] as String,
        isDone: json['isDone'] as bool,
        isImportant: json['isImportant'] as bool? ?? false,
      );
}
