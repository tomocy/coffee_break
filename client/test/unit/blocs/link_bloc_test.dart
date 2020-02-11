import 'package:coffee_break/blocs/link_bloc.dart';
import 'package:coffee_break/domain/models/link.dart';
import 'package:coffee_break/domain/resources/link_repository.dart';
import 'package:coffee_break/infra/link_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() => group('LinkBloc test', () {
      group('fetch', () {
        test('success', () async {
          final expected = <Link>[
            Link.todo(
              uri: 'uri 1',
              title: 'title 1',
            ),
            Link.todo(
              uri: 'uri 2',
              title: 'title 2',
            ),
            Link.done(
              uri: 'uri 3',
              title: 'title 3',
            ),
          ];
          final repository = MockLinkRepository(
            links: expected,
          );
          final bloc = LinkBloc(repository);

          bloc.fetch.add(null);
          await expectLater(
            bloc.links,
            emits(expected),
          );
          bloc.dispose();
        });

        test('failed', () async {
          final repository = MockLinkRepository(
            failer: () => true,
          );
          final bloc = LinkBloc(repository);

          bloc.fetch.add(null);
          await expectLater(
            bloc.links,
            emitsError(const LinkRepositoryFetchException()),
          );
          bloc.dispose();
        });
      });

      group('save', () {
        test('success', () async {
          final expected = Link.todo(
            uri: 'uri 1',
            title: 'title 1',
          );
          final repository = MockLinkRepository();
          final bloc = LinkBloc(repository);

          bloc.save.add(expected);
          await expectLater(
            bloc.links,
            emitsThrough(<Link>[expected]),
          );
          bloc.save.add(expected);
          await expectLater(
            bloc.saved,
            emits(true),
          );
          bloc.dispose();
        });

        test('failed', () async {
          final repository = MockLinkRepository(
            failer: () => true,
          );
          final bloc = LinkBloc(repository);

          bloc.save.add(Link());
          await expectLater(
            bloc.saved,
            emitsError(isInstanceOf<LinkRepositorySaveException>()),
          );
          bloc.dispose();
        });
      });
    });
