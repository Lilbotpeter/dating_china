import 'package:equatable/equatable.dart';

import '../../domain/entities/todo_entities.dart';

sealed class TodosState extends Equatable{
  const TodosState();
  @override
  List<Object?> get props => [];
}

class TodosLoading extends TodosState{
  const TodosLoading();
}

class TodosLoaded extends TodosState{
  final List<Todo> items;
  const TodosLoaded(this.items);

  @override
  List<Object?> get props => [items];
}

class TodosError extends TodosState{
  final String message;
  const TodosError(this.message);

  @override
  List<Object?> get props => [message];
}