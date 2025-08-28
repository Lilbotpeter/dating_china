import 'package:dating_china/features/todos/domain/repository/todos_repository.dart';
import 'package:dating_china/features/todos/presentation/bloc/todos_event.dart';
import 'package:dating_china/features/todos/presentation/bloc/todos_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/data_state.dart';
import '../../domain/entities/todo_entities.dart';

class TodosBloc extends Bloc<TodoEvent, TodosState>{
  final TodoRepository repo;

  TodosBloc(this.repo) : super(const TodosLoading()){
     on<TodosStarted>(_onStarted);
    on<TodosAdded>(_onAdded);
    on<TodosToggled>(_onToggled);
    on<TodosRemoved>(_onRemoved);
    on<TodosClearCompleted>(_onClearCompleted);

  }

  Future<void> _reload(Emitter<TodosState> emitter) async{
    final res = await repo.list();
    if(res is DataSuccess<List<Todo>>){
      emit(TodosLoaded(res.data!));
    }else if(res is DataFailed){
      emit(TodosError(res.error?.message ?? 'Unknow error'));
    }
  }

  Future<void> _onStarted(TodosStarted e, Emitter<TodosState> emit) async {
    emit(const TodosLoading());
    await _reload(emit);
  }

  Future<void> _onAdded(TodosAdded e, Emitter<TodosState> emit) async {
    if(e.title.trim().isEmpty) return;
    final addRes = await repo.add(
      Todo(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
         title: e.title.trim(),
          done: false));

    if(addRes is DataFailed) {
      emit(TodosError(addRes.error?.message ?? 'Add failed'));
      return;
    }
    await _reload(emit);
  }

  Future<void> _onToggled(TodosToggled e, Emitter<TodosState> emit) async{
    final res = await repo.toggle(e.id);
    if(res is DataFailed){
      emit(TodosError(res.error?.message ?? 'Toggle Failed'));
      return;
    }
    await _reload(emit);
  }

  Future<void> _onRemoved(TodosRemoved e,Emitter<TodosState> emit) async{
    final res = await repo.remove(e.id);
    if(res is DataFailed){
      emit(TodosError(res.error?.message ?? 'Remove failed'));
      return;
    }
    await _reload(emit);
  }

  Future<void> _onClearCompleted(TodosClearCompleted e,Emitter<TodosState> emit) async{
    final res = await repo.clearCompleted();
    if(res is DataFailed){
      emit(TodosError(res.error?.message ?? 'Clear Completed failed'));
      return;
    }
    await _reload(emit);
  }





} 