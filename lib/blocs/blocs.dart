import 'package:todoliist/blocs/events.dart';
import 'package:todoliist/blocs/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoliist/database/repositories.dart';

class TodoBloc extends Bloc<TodoEvents, TodoState>{
  final Repository repository;
  TodoBloc(this.repository) : super(LoadingState()) {
    on<LoadTodoEvent>((event, emit) async {
      emit (LoadingState());
      try{
        final todos = await repository.GetTodos();
        emit (LoadedState(todos));
      }catch(e){
        emit (ErrorState(e.toString()));
      }
    }
    );
    on<AddTodoEvent>((event, emit)async{
      try{
        await repository.PostTodos(event.todoJson);
      }catch(e){
        emit (ErrorState(e.toString()));
      }
      try{
        final todos = await repository.GetTodos();
        emit (LoadedState(todos));
      }catch(e){
        emit (ErrorState(e.toString()));
      }
    });
    on<DeleteTodoEvent>((event, emit) async{
      try{
        await repository.DeleteTodos(event.todoJson);
      }catch(e){
        emit (ErrorState(e.toString()));
      }
      try{
        final todos = await repository.GetTodos();
        emit (LoadedState(todos));
      }catch(e){
        emit (ErrorState(e.toString()));
      }
    });
  }

}