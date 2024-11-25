class Task {
  final String title;

  final int listid;
  final String time;

  Task({required this.title,required this.listid, required this.time});

 
  Map<String, dynamic> toMap() {
    return {'title': title, 'id':listid, 'time': time};
  }

  
  static Task fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'],
      listid: map['id'],
      time: map['time'],
    );
  }
}
