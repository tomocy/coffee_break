import 'package:coffee_break/domain/models/link.dart';
import 'package:coffee_break/domain/resources/link_repository.dart';
import 'package:coffee_break/infra/mock.dart';

class MockLinkRepository extends Mock implements LinkRepository {
  MockLinkRepository({Failer failer}) : super(failer: failer);

  final _links = <Link>[
    Link.todo(
      uri: 'https://twitter.com/towocy',
      title: 'Twitter',
      createdAt: DateTime(2020, 1, 1),
      dueDate: DateTime.now(),
    ),
    Link.todo(
      uri: 'https://github.com/tomocy',
      title: 'GitHub',
      createdAt: DateTime(2020, 1, 11),
    ),
  ];

  @override
  Future<List<Link>> fetch() async =>
      !doFail ? _links : throw LinkRepositoryFetchException();

  @override
  Future<void> update(Link oldLink, Link newLink) async {
    if (doFail) {
      throw LinkRepositoryUpdateException(
        oldLink,
        newLink,
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
    if (doFail) {
      throw LinkRepositorySaveException(link);
    }

    final i = _links.indexOf(link);
    if (i < 0) {
      _links.add(link);
      return;
    }

    _links[i] = link;
  }

  @override
  Future<void> delete(Link link) async =>
      !doFail ? _links.remove(link) : throw LinkRepositoryDeleteException(link);
}
