import 'package:dating_china/features/todos/presentation/bloc/todos_bloc.dart';
import 'package:dating_china/features/todos/presentation/bloc/todos_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/todo_entities.dart';
import '../bloc/todos_state.dart';

class TodosPage extends StatefulWidget {
  const TodosPage({super.key});

  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TodosBloc>(context).add(TodosStarted());
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checklist Todos'),
        actions: [
          IconButton(
            tooltip: 'Clear completed',
            onPressed: () => BlocProvider.of<TodosBloc>(context).add(TodosClearCompleted()),
            icon: const Icon(Icons.cleaning_services_outlined)
            )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Add todo',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _submit(),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: const Icon(Icons.add),
                  label: const Text('Add'),
                )
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: BlocConsumer<TodosBloc, TodosState>(
              listener: (_, s) {
                if (s is TodosError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(s.message)),
                  );
                }
              },
              builder: (_, s) {
                if (s is TodosLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (s is TodosError) {
                  return Center(child: Text('Error: ${s.message}'));
                }
                final items = (s as TodosLoaded).items;
                if (items.isEmpty) {
                  return const Center(child: Text('No items yet'));
                }
                return ListView.separated(
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (_, i) => _TodoTile(items[i]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _submit(){
    final text = _controller.text.trim();
    if(text.isEmpty) return;
    BlocProvider.of<TodosBloc>(context).add(TodosAdded(text));
    _controller.clear();
  }
}

class _TodoTile extends StatelessWidget {
  final Todo todo;
  const _TodoTile(this.todo);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(todo.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => BlocProvider.of<TodosBloc>(context).add(TodosRemoved(todo.id)),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: CheckboxListTile(
        value: todo.done,
        onChanged: (_) => BlocProvider.of<TodosBloc>(context).add(TodosToggled(todo.id)),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.done ? TextDecoration.lineThrough : null,
            color: todo.done ? Colors.grey : null,
          ),
        ),
      ),
    );
  }
}