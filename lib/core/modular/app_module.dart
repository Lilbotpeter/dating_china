import 'package:dating_china/core/modular/shell.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../features/todos/todos_module.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {

  }

  @override
  void routes(RouteManager r) {
     r.child(Modular.initialRoute, child: (_) => const AppShell());
    r.module('/todos', module: TodosModule());
  }

}