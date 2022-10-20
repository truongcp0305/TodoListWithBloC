import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../models/todo_model.dart';

@immutable
abstract class TodoState extends Equatable{}

class LoadingState extends TodoState{

  List<Object?> get props => [];
}

class LoadedState extends TodoState{
  final List<Todo> todos;
  LoadedState(this.todos);
  List<Object?> get props => [todos];
}

class ErrorState extends TodoState{
  final String error;
  ErrorState(this.error);
  List<Object?> get props => [error];
}
