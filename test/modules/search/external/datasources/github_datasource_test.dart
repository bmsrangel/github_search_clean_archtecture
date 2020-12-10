import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_seach_clean_archtecture/modules/search/domain/errors/errors.dart';
import 'package:github_seach_clean_archtecture/modules/search/external/datasources/github_datasource.dart';
import 'package:mockito/mockito.dart';

import '../../utils/github_response.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();
  final datasource = GithubDatasource(dio);

  test('Deve retornar uma lista de ResultSearchModel', () async {
    when(dio.get(any)).thenAnswer(
        (_) async => Response(data: jsonDecode(githubResult), statusCode: 200));

    final future = datasource.getSearch('bruno');
    expect(future, completes);
  });
  test('Deve retornar um erro se o código não for 200', () async {
    when(dio.get(any)).thenAnswer(
        (_) async => Response(data: jsonDecode(githubResult), statusCode: 401));

    final future = datasource.getSearch('bruno');
    expect(future, throwsA(isA<DatasourceError>()));
  });
  test('Deve retornar um exception se tiver um erro no dio', () async {
    when(dio.get(any)).thenThrow(Exception());

    final future = datasource.getSearch('bruno');
    expect(future, throwsA(isA<Exception>()));
  });
}
