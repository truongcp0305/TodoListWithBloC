class Todo {
  final int id;
  final String text;

  Todo({required this.id, required this.text});

  factory Todo.fromJson(Map<String, dynamic> json){
    return Todo(
      id: json['id'] ?? 'no data',
      text: json['text'] ?? 'no data'
    );
  }

  Map<String, dynamic> ToJson (){
    return{
      'text' : text,
    };
  }
  Map<String, dynamic> ToJson2 (){
    return{
      'text' : text,
      'id' : id.toString()
    };
  }
}