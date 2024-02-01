import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/task/task_bloc.dart';

class Searchbox extends StatefulWidget {
  const Searchbox({super.key});

  @override
  State<Searchbox> createState() => _SearchboxState();
}

class _SearchboxState extends State<Searchbox> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          BlocProvider.of<TaskBloc>(context).add(SearchBox(text: _searchController.text));
        },
        decoration: const InputDecoration(
          hintText: 'Search',
          prefixIcon: Icon(
            Icons.search,
            size: 30,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
