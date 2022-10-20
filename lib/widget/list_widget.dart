import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoliist/blocs/blocs.dart';
import 'package:todoliist/blocs/events.dart';
import 'package:todoliist/database/repositories.dart';
import '../blocs/state.dart';
import '../models/todo_model.dart';

class ListTodo extends StatefulWidget {
  const ListTodo({Key? key}) : super(key: key);

  @override
  State<ListTodo> createState() => _ListTodoState();
}

class _ListTodoState extends State<ListTodo> {
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[ Container(
              height: 60,
              width: 200,
              margin: const EdgeInsets.only(left: 10),
              child: TextFormField(
                style: const TextStyle(color: Colors.black),
                controller: textController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Add to do',
                  hintStyle: TextStyle(color: Colors.black26),
                ),
              ),
          ),

            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: RaisedButton(
                onPressed: (){
                  (context).read<TodoBloc>().add(AddTodoEvent({'text': textController.text}));
                },
                child: const Text(
                  'Add',
                  style: TextStyle(
                    color: Colors.cyan,
                    fontWeight: FontWeight.w500,
                    fontSize: 20
                  ),
                ),
              ),
            )
            ]
    ),



        BlocProvider(
          create: (context) => TodoBloc(
            RepositoryProvider.of<Repository>(context)
          )..add(LoadTodoEvent()),
          child: BlocBuilder<TodoBloc, TodoState>(
            builder: (context, state){
              if(state is LoadingState){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if(state is LoadedState){
                List<Todo> todoList = state.todos;
                return Expanded(
                  child: ListView.builder(
                    itemCount: todoList.length,
                    itemBuilder: (_,index){
                      return Container(
                        height: 130,
                        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Center(
                            child: Text(
                              todoList[index].text,
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black
                              ),
                            )
                        ),
                      );
                    },
                  ),
                );
              }
              if(state is ErrorState){
                String err = state.error;
                return Center(child: Text(err),);
              }
              return Container(
                child: Text('err'),
              );
            },
          ),
        ),
      ],
    );
  }
}
