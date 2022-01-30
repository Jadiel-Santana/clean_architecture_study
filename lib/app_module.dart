import 'package:clean_architecture_study/modules/search/domain/usecases/search_by_text.dart';
import 'package:clean_architecture_study/modules/search/external/datasources/github_datasource.dart';
import 'package:clean_architecture_study/modules/search/infra/repositories/search_repository_impl.dart';
import 'package:clean_architecture_study/modules/search/presenter/search/search_bloc.dart';
import 'package:clean_architecture_study/modules/search/presenter/search/search_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
    Bind.factory((i) => Dio()),
    Bind.factory((i) => GithubDatasource(i())),
    Bind.factory((i) => SearchRepositoryImpl(i())),
    Bind.factory((i) => SearchByTextImp(i())),
    Bind.factory((i) => SearchBloc(i())),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (_, args) => SearchPage()),
  ];
}