import 'dart:convert';

import 'package:clean_architecture_study/modules/search/domain/errors/errors.dart';
import 'package:clean_architecture_study/modules/search/external/datasources/github_datasource.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../utils/github_response.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();
  final datasource = GithubDatasource(dio);

  test('Deve retornar uma List<ResultSearchModel>', () {
    when(dio.get(any)).thenAnswer(
      (_) async => Response(
        data: jsonDecode(githubResult),
        statusCode: 200,
        requestOptions: null,
      ),
    );

    final future = datasource.getSearch('searchText');
    expect(future, completes);
  });

  test('Deve retornar um DatasourceError se o statusCode não for 200', () {
    when(dio.get(any)).thenAnswer(
      (_) async => Response(
        data: null,
        statusCode: 401,
        requestOptions: null,
      ),
    );

    final future = datasource.getSearch('searchText');
    expect(future, throwsA(isA<DatasourceError>()));
  });
}
