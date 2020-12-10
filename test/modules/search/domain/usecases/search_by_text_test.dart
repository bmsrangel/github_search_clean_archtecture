import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_seach_clean_archtecture/modules/search/domain/entities/result_search.dart';
import 'package:github_seach_clean_archtecture/modules/search/domain/errors/errors.dart';
import 'package:github_seach_clean_archtecture/modules/search/domain/repositories/search_repository.dart';
import 'package:github_seach_clean_archtecture/modules/search/domain/usecases/search_by_text.dart';
import 'package:mockito/mockito.dart';

class SearchRepositoryMock extends Mock implements SearchRepository {}

main() {
  final repository = SearchRepositoryMock();
  final usecase = SearchByTextImpl(repository);

  test('Deve retornar uma lista de ResultSearch', () async {
    when(repository.search(any))
        .thenAnswer((_) async => Right(<ResultSearch>[]));
    // usecase.call('searchText');
    final result = await usecase(
        'jacob'); // Pode ser chamado desta forma porque ele implementa um método chamado 'call'
    // expect(result, isA<Right>());
    expect(result | null, isA<List<ResultSearch>>());
  });
  test('Deve retornar exception caso o texto seja inválido', () async {
    when(repository.search(any))
        .thenAnswer((_) async => Right(<ResultSearch>[]));
    // usecase.call('searchText');
    var result = await usecase(
        null); // Pode ser chamado desta forma porque ele implementa um método chamado 'call'
    // expect(result, isA<Right>());
    // expect(result | null, null);
    // expect(result.isLeft(), true);
    expect(result.fold(id, id), isA<InvalidTextError>());
    result = await usecase('');
    expect(result.fold(id, id), isA<InvalidTextError>());
  });
}
