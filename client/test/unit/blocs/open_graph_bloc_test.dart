import 'package:coffee_break/blocs/open_graph_bloc.dart';
import 'package:coffee_break/domain/models/open_graph.dart';
import 'package:coffee_break/domain/resources/open_graph_repository.dart';
import 'package:coffee_break/infra/open_graph_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() => group('OpenGraphBloc test', () {
      group('fetch', () {
        test('success', () async {
          const expected = OpenGraph(
            title: 'test open graph',
          );
          const repository = MockOpenGraphRepository(
            openGraphs: {'test': expected},
          );
          final bloc = OpenGraphBloc(repository);

          bloc.fetch.add('test');
          await expectLater(
            bloc.openGraph,
            emits(expected),
          );
          bloc.dispose();
        });

        test('failed', () async {
          final repository = MockOpenGraphRepository(
            failer: () => true,
          );
          final bloc = OpenGraphBloc(repository);

          bloc.fetch.add('');
          await expectLater(
            bloc.openGraph,
            emitsError(isInstanceOf<OpenGraphRepositoryFetchException>()),
          );
          bloc.dispose();
        });
      });
    });
