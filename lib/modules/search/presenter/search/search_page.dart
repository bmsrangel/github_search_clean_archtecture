import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'search_bloc.dart';
import 'states/state.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final bloc = Modular.get<SearchBloc>();

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Github Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
            child: TextField(
              onChanged: bloc.add,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Search...'),
            ),
          ),
          Expanded(
            child: StreamBuilder<SearchState>(
                stream: bloc,
                builder: (context, snapshot) {
                  final state = bloc.state;

                  if (state is SearchStart) {
                    return Center(
                      child: Text('Digite um texto'),
                    );
                  } else if (state is SearchError) {
                    return Center(
                      child: Text('Houve um erro'),
                    );
                  } else if (state is SearchLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final list = (state as SearchSuccess).list;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: list.length,
                    itemBuilder: (_, id) {
                      final item = list[id];
                      return ListTile(
                        leading: item.avatarUrl == null
                            ? Container()
                            : CircleAvatar(
                                backgroundImage: NetworkImage(item.avatarUrl),
                              ),
                        title: Text(item.login ?? ''),
                        subtitle: Text(item.htmlUrl ?? ''),
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
