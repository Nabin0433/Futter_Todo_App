// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/cubit/add_todo_cubit.dart';
import 'package:test/cubit/todo_cubit.dart';
import 'package:test/cubit/update_todo_cubit.dart';
import 'package:test/home/model/todo.dart';
import 'package:test/home/screens/Add_todo_screen.dart';
import 'package:test/home/screens/Edit_todo_screen.dart';
import 'package:test/home/screens/TodoScreen.dart';
import 'package:test/shared/constant/Strings.dart';
import 'package:test/shared/data/network_service.dart';
import 'package:test/shared/data/repository.dart';

class MyRoute {
  late Repository repository;
  late TodoCubit todosCubit;

  MyRoute() {
    repository = Repository(networkService: NetworkService());
    todosCubit = TodoCubit(repository: repository);
  }

  Route generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesNames.home:
        return MaterialPageRoute(
          builder: (ctx) => BlocProvider.value(
            value: todosCubit,
            child: const Todoscreen(),
          ),
        );
      case RoutesNames.addTodo:
        return MaterialPageRoute(
          builder: (ctx) => BlocProvider(
            create: (context) => AddTodoCubit(
              repository: repository,
              todoCubit: todosCubit,
            ),
            child: const AddTodoScreen(),
          ),
        );
      case RoutesNames.editTodo:
        return MaterialPageRoute(
          builder: (ctx) => BlocProvider(
            create: (context) => UpdateTodoCubit(
              repository: repository,
              todoCubit: todosCubit,
            ),
            child: EditTodoScreen(
              todo: settings.arguments as Todo,
            ),
          ),
        );
      default:
        return MaterialPageRoute(builder: (ctx) => const Todoscreen());
    }
  }
}
