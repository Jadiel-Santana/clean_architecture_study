import 'package:clean_architecture_study/modules/search/domain/entities/result_search.dart';
import 'package:clean_architecture_study/modules/search/domain/errors/errors.dart';
import 'package:clean_architecture_study/modules/search/domain/repositories/search_repository.dart';
import 'package:clean_architecture_study/modules/search/infra/datasource/search_datasource.dart';
import 'package:dartz/dartz.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchDatasource datasource;

  SearchRepositoryImpl(this.datasource);

  @override
  Future<Either<FailureSearch, List<ResultSearch>>> search(String searchText) async {
    try {
      final result = await datasource.getSearch(searchText);
      return Right(result);
    } on DatasourceError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(DatasourceError());
    }
  }
}