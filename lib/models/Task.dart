
class Task {
  final  int taskVal;
  final  String taskDetails;
  final  String colorVal;

  Task._({this.taskDetails,this.taskVal,this.colorVal});


  factory Task.fromJson(Map<String, dynamic> json) {
    return new Task._(
        taskDetails: json['taskdetails'],
        taskVal: json['taskVal'],
        colorVal: json['colorVal']
    );
  }

  @override
  String toString() => "Record<$taskVal:$taskDetails>";
}

