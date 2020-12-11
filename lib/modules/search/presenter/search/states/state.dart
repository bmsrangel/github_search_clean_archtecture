import 'package:github_seach_clean_archtecture/modules/search/domain/entities/result_search.dart';
import 'package:github_seach_clean_archtecture/modules/search/domain/errors/errors.dart';

abstract class SearchState {}

class SearchSuccess extends SearchState {
  SearchSuccess(this.list);

  final List<ResultSearch> list;
}

class SearchLoading extends SearchState {}

class SearchStart extends SearchState {}

class SearchError extends SearchState {
  final FailureSearch erro;

  SearchError(this.erro);
}
