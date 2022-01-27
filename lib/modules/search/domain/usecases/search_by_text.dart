import 'package:clean_architecture_study/modules/search/domain/entities/result_search.dart';
import 'package:clean_architecture_study/modules/search/domain/errors/errors.dart';
import 'package:clean_architecture_study/modules/search/domain/repositories/search_repository.dart';
import 'package:dartz/dartz.dart';

abstract class SearchByText {
  Future<Either<FailureSearch, List<ResultSearch>>> call(String searchText);
}

class SearchByTextImp implements SearchByText {
  final SearchRepository repository;

  SearchByTextImp(this.repository);

  @override
  Future<Either<FailureSearch, List<ResultSearch>>> call(String searchText) async {
    if(searchText == null || searchText.isEmpty) {
      return Left(InvalidTextError());
    }
    return repository.search(searchText);
  }
}