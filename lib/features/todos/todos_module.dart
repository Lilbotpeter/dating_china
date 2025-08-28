import 'package:dating_china/features/todos/data/repositories/todos_repository_memory.dart';
import 'package:dating_china/features/todos/domain/repository/todos_repository.dart';
import 'package:dating_china/features/todos/presentation/bloc/todos_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/pages/todos_page.dart';

class TodosModule extends Module{
  @override
  void binds(Injector i) {
    i.addLazySingleton<TodoRepository>(() => TodosRepositoryMemory());
    i.add<TodosBloc>(() => TodosBloc(i<TodoRepository>()));
  }

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (_){
      final bloc = Modular.get<TodosBloc>();
      return BlocProvider.value(value: bloc,child: const TodosPage(),);
    });
  }
}