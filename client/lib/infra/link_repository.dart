import 'dart:math';
import 'package:coffee_break/domain/models/link.dart';
import 'package:coffee_break/domain/resources/link_repository.dart';

class MockLinkRepository implements LinkRepository {
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
  final _random = Random();

  @override
  Future<List<Link>> fetch() async => _random.nextBool()
      ? _links
      : throw LinkRepositoryFetchException('failed to fetch links');

  @override
  Future<void> save(Link link) async {
    if (_random.nextBool()) {
      throw LinkRepositorySaveException('failed to save links');
    }

    final i = _links.indexOf(link);
    if (i < 0) {
      _links.add(link);
      return;
    }

    _links[i] = link;
  }

  @override
  Future<void> delete(Link link) async => _random.nextBool()
      ? _links.remove(link)
      : throw LinkRepositoryDeleteException('failed to delete link');
}
