import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class TodoEvents extends Equatable{
  const TodoEvents();
}

class LoadTodoEvent extends TodoEvents{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddTodoEvent extends TodoEvents{
  Map<String, dynamic> todoJson;
  AddTodoEvent(this.todoJson);
  List<Object?> get props => [];
}

class DeleteTodoEvent extends TodoEvents{
  String todoJson;
  DeleteTodoEvent(this.todoJson);
  List<Object?> get props => [];
}