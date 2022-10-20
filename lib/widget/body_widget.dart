import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/blocs.dart';
import '../blocs/events.dart';
import '../blocs/state.dart';
import '../database/repositories.dart';
import '../models/todo_model.dart';
import 'package:get/get.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}


class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    var textController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Todo app'
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocProvider(
            create: (context) => TodoBloc(
                RepositoryProvider.of<Repository>(context)
            )..add(LoadTodoEvent()),
            child: BlocBuilder<TodoBloc, TodoState>(
              builder: (context, state){
                if(state is LoadingState){
                  return const Center(child: CircularProgressIndicator(),);
                }
                if(state is LoadedState){
                  List<Todo> todoList = state.todos;
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
                              child: ElevatedButton(
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

                      Expanded(
                        child: ListView.builder(
                          itemCount: todoList.length,
                          itemBuilder: (context,index){
                            return GestureDetector(
                              onTap: (){
                                (context).read<TodoBloc>().add(DeleteTodoEvent(todoList[index].id.toString()));
                              },
                              child: Container(
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
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
                if(state is ErrorState){
                  String err = state.error;
                  return Center(child: Text(err),);
                }

                return const Center(child: Text('Error'),);
              },
        ),
    ),
          ),
    ]
      ),
    );

  }
}
