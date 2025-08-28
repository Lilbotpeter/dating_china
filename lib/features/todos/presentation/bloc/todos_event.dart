import 'package:equatable/equatable.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();
  @override
  List<Object?> get props => [];
}

class TodosStarted extends TodoEvent{
  const TodosStarted();
}

class TodosAdded extends TodoEvent{
  final String title;
  const TodosAdded(this.title);

  @override
  List<Object?> get props => [title];
}

class TodosToggled extends TodoEvent{
  final String id;
  const TodosToggled(this.id);

  @override
  List<Object?> get props => [id];
}

class TodosRemoved extends TodoEvent{
  final String id;
  const TodosRemoved(this.id);

  @override
  List<Object?> get props => [id];
}

class TodosClearCompleted extends TodoEvent{
  const TodosClearCompleted();
}

