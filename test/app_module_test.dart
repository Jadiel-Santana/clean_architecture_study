import 'dart:convert';

import 'package:clean_architecture_study/app_module.dart';
import 'package:clean_architecture_study/modules/search/domain/entities/result_search.dart';
import 'package:clean_architecture_study/modules/search/domain/usecases/search_by_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:modular_test/modular_test.dart';

import 'modules/search/utils/github_response.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();

  initModule(AppModule(), replaceBinds: [
    Bind<Dio>((i) => dio),
  ]);

  test('Deve recuperar o Usecase sem erro', () {
    final usecase = Modular.get<SearchByText>();
    expect(usecase, isA<SearchByTextImp>());
  });

  test('Deve trazer uma List<ResultSearch>', () async {
    when(dio.get(any)).thenAnswer(
          (_) async => Response(
        data: jsonDecode(githubResult),
        statusCode: 200,
        requestOptions: null,
      ),
    );

    final usecase = Modular.get<SearchByText>();
    final result = await usecase('Jadiel');
    expect(result | null, isA<List<ResultSearch>>());
  });
}