import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
  
}

class _AppShellState extends State<AppShell> {
  final _index = 0;
  final _tab = const [];
   @override
  void initState() {
    super.initState();
    Modular.to.navigate('/todos');
  }

  @override
  Widget build(BuildContext context) {
     return const Scaffold(body: RouterOutlet());
  }
}