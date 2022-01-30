import 'package:clean_architecture_study/modules/search/presenter/search/search_bloc.dart';
import 'package:clean_architecture_study/modules/search/presenter/states/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _bloc = Modular.get<SearchBloc>();

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
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
            padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: TextField(
              onChanged: _bloc.add,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Search...'),
            ),
          ),
          Expanded(
            child: StreamBuilder(
                stream: _bloc,
                builder: (context, snapshot) {
                  final state = _bloc.state;
                  if (state is SearchStart) {
                    return Center(
                      child: Text('Digite um texto'),
                    );
                  }
                  if (state is SearchError) {
                    return Center(
                      child: Text('Houve um erro'),
                    );
                  }
                  if (state is SearchLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final list = (state as SearchSuccess).list;
                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (_, i) {
                      return ListTile(
                        leading: (list[i].image == null)
                            ? Container(width: 20,)
                            : CircleAvatar(
                                backgroundImage: NetworkImage(list[i].image),
                              ),
                        title: Text(list[i].title ?? ''),
                        subtitle: Text(list[i].id.toString() ?? ''),
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
