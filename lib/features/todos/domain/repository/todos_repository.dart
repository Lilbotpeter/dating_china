import 'package:dating_china/features/todos/domain/entities/todo_entities.dart';

import '../../../../core/resources/data_state.dart';

abstract class TodoRepository{
  Future<DataState<List<Todo>>> list();
  Future<DataState<void>> add(Todo todo);
  Future<DataState<void>> toggle(String id);
  Future<DataState<void>> remove(String id);
  Future<DataState<void>> clearCompleted();
}