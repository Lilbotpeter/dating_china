import 'package:dating_china/core/resources/data_state.dart';
import 'package:dating_china/features/todos/domain/entities/todo_entities.dart';
import 'package:dating_china/features/todos/domain/repository/todos_repository.dart';
import 'package:dio/dio.dart';

class TodosRepositoryMemory implements TodoRepository{
  final List<Todo> _store = [];

  @override
  Future<DataState<void>> add(Todo todo) async {
    try{
      _store.add(todo);
      return const DataSuccess(null);
    }catch(e){
      return DataFailed(
        DioException(
          requestOptions: RequestOptions(path: '/todos/add'),
          error: e
        ),
      );
    }
  }

  @override
  Future<DataState<List<Todo>>> list() async{
    try{
      return DataSuccess(List<Todo>.unmodifiable(_store.reversed));
    }catch(e){
      return DataFailed(
        DioException(
          requestOptions: RequestOptions(path: '/todos'),
          error: e
        )
      );
    }
  }

  @override
  Future<DataState<void>> remove(String id) async{
    try{
      _store.removeWhere((element) => element.id == id);
      return const DataSuccess(null);
    }catch(e){
      return DataFailed(
        DioException(
          requestOptions: RequestOptions(path: '/todos/remove'),
          error: e
        )
      );
    }
  }

  @override
  Future<DataState<void>> toggle(String id) async{
    try{
      final i = _store.indexWhere((element) => element.id == id);
      if(i != -1){
        _store[i] = _store[i].copyWith(done: !_store[i].done);
      }
      return const DataSuccess(null);
    }catch(e){
      return DataFailed(
        DioException(
          requestOptions: RequestOptions(path: 'todos/toggle'),
          error: e
        )
      );
    }
  }
  
  @override
  Future<DataState<void>> clearCompleted() async{
    try{
      _store.removeWhere((element) => element.done);
      return const DataSuccess(null);
    }catch(e){
      return DataFailed(
        DioException(
          requestOptions: RequestOptions(
            path: '/todo/clearCompleted',),
            error: e
            )
      );
    }
  }

}