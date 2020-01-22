import 'dart:math';
import 'package:coffee_break/domain/models/link.dart';
import 'package:coffee_break/domain/resources/link_repository.dart';

class MockLinkRepository implements LinkRepository {
  MockLinkRepository({this.randomToFail});

  final _links = <Link>[
    Link.todo(
      uri: 'https://twitter.com/towocy',
      createdAt: DateTime(2020, 1, 1),
    ),
    Link.todo(
      uri: 'https://github.com/tomocy',
      createdAt: DateTime(2020, 1, 11),
    ),
  ];
  final Random randomToFail;

  bool get _doFail => randomToFail?.nextBool() ?? false;

  @override
  Future<List<Link>> fetch() async => !_doFail
      ? _links
      : throw LinkRepositoryFetchException('failed to fetch links');

  @override
  Future<void> update(Link oldLink, Link newLink) async {
    if (_doFail) {
      throw LinkRepositoryUpdateException(
        oldLink,
        newLink,
        'failed to update link',
      );
    }
    if (oldLink == newLink) {
      return;
    }

    try {
      await save(newLink);
      await delete(oldLink);
    } on LinkRepositorySaveException {
      throw LinkRepositoryUpdateException(oldLink, newLink);
    } on LinkRepositoryDeleteException {
      _links.remove(newLink);
      throw LinkRepositoryUpdateException(oldLink, newLink);
    }
  }

  @override
  Future<void> save(Link link) async {
    if (_doFail) {
      throw LinkRepositorySaveException(link, 'failed to save links');
    }

    final i = _links.indexOf(link);
    if (i < 0) {
      _links.add(link);
      return;
    }

    _links[i] = link;
  }

  @override
  Future<void> delete(Link link) async => !_doFail
      ? _links.remove(link)
      : throw LinkRepositoryDeleteException(link, 'failed to delete link');
}
