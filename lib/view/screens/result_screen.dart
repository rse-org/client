import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rse/all.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final List<Question> data = [];
  late Map<int, bool> expandedMap = {};

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlayBloc, PlayState>(
      builder: (context, state) {
        if (state is ResultShow) {
          final result = state.result;
          return SizedBox(
            height: H(context),
            child: SingleChildScrollView(
              child: _buildPanel(result.questions),
            ),
          );
        }
        return const Text('Gogog');
      },
      listener: (context, state) {},
    );
  }

  @override
  void initState() {
    super.initState();
  }

  List<ExpansionPanel> _buildChildren(data) {
    List<ExpansionPanel> items = [];
    for (var i = 0; i < data.length; i++) {
      items.add(ExpansionPanel(
        headerBuilder: (BuildContext context, bool isExpanded) {
          return ListTile(
            title: Text(data[i].body),
          );
        },
        body: ListTile(
            title: const Text('sosos'),
            subtitle: const Text('Delete'),
            trailing: const Icon(Icons.delete),
            onTap: () {
              // setState(() {
              //   data.removeWhere(
              //       (Question currentItem) => data[i] == currentItem);
              // });
            }),
        isExpanded: expandedMap[i] ?? false,
      ));
    }
    return items;
  }

  Widget _buildPanel(data) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          expandedMap[index] = !isExpanded;
        });
      },
      children: _buildChildren(data),
    );
  }
}
