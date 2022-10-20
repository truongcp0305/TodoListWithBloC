import 'dart:convert';
import 'package:http/http.dart';
import '../models/todo_model.dart';

class Repository {
  String endpoint = 'https://fakeapitotodolist.herokuapp.com/todos';
  Future<List<Todo>> GetTodos() async{
    Response response = await get(Uri.parse(endpoint));
    if(response.statusCode == 200){
      final List result = jsonDecode(response.body);
      return result.map(((e) => Todo.fromJson(e))).toList();
    }else{
      throw Exception(response.reasonPhrase);
    }
  }

  Future PostTodos(todo) async{
    Response response = await post(Uri.parse(endpoint), body: todo );
    if(response.statusCode <= 226){

    }else{
      throw Exception(response.reasonPhrase);
    }
  }

  Future DeleteTodos(id) async{
    final String url = '$endpoint/$id';
    Response response = await delete(Uri.parse(url) );
    if(response.statusCode <=  226){

    }else{
      throw Exception(response.reasonPhrase);
    }
  }
}