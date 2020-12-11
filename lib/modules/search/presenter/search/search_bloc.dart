import 'package:bloc/bloc.dart';
import 'package:github_seach_clean_archtecture/modules/search/domain/usecases/search_by_text.dart';
import 'package:github_seach_clean_archtecture/modules/search/presenter/search/states/state.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends Bloc<String, SearchState> {
  SearchBloc(this.usecase) : super(SearchStart());

  final SearchByText usecase;

  @override
  Stream<SearchState> mapEventToState(String searchText) async* {
    yield SearchLoading();
    final result = await usecase(searchText);
    yield result.fold((l) => SearchError(l), (r) => SearchSuccess(r));
  }

  @override
  Stream<Transition<String, SearchState>> transformEvents(
      Stream<String> events, transitionFn) {
    return super.transformEvents(
        events.debounceTime(Duration(milliseconds: 800)), transitionFn);
  }
}
