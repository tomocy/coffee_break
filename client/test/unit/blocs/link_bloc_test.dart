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
            emitsError(isInstanceOf<LinkRepositoryFetchException>()),
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

      group('update', () {
        test('success', () async {
          final old = Link.todo(
            uri: 'uri 1',
            title: 'title 2',
          );
          final expected = old.copyWith(
            done: true,
          );
          final repository = MockLinkRepository();
          final bloc = LinkBloc(repository);

          final event = UpdateLinkEvent(
            oldLink: old,
            newLink: expected,
          );
          bloc.update.add(event);
          await expectLater(
            bloc.links,
            emitsThrough(<Link>[expected]),
          );
          bloc.update.add(event);
          await expectLater(
            bloc.updated,
            emits(true),
          );
          bloc.dispose();
        });

        test('failed', () async {
          final repository = MockLinkRepository(
            failer: () => true,
          );
          final bloc = LinkBloc(repository);

          bloc.update.add(UpdateLinkEvent(
            oldLink: Link(),
            newLink: Link(),
          ));
          await expectLater(
            bloc.updated,
            emitsError(isInstanceOf<LinkRepositoryUpdateException>()),
          );
          bloc.dispose();
        });
      });

      group('delete', () {
        test('success', () async {
          final link = Link.todo(
            uri: 'uri 1',
            title: 'title 1',
          );
          final repository = MockLinkRepository(
            links: [link],
          );
          final bloc = LinkBloc(repository);

          bloc.delete.add(link);
          await expectLater(
            bloc.links,
            emits(<Link>[]),
          );
          bloc.save.add(link);
          bloc.delete.add(link);
          await expectLater(
            bloc.deleted,
            emits(link),
          );
          bloc.dispose();
        });

        test('failed', () async {
          final repository = MockLinkRepository(
            failer: () => true,
          );
          final bloc = LinkBloc(repository);

          bloc.delete.add(Link());
          await expectLater(
            bloc.deleted,
            emitsError(isInstanceOf<LinkRepositoryDeleteException>()),
          );
          bloc.dispose();
        });
      });
    });
