import 'dart:math';
import 'package:coffee_break/domain/models/link.dart';
import 'package:coffee_break/domain/resources/link_repository.dart';

class MockLinkRepository implements LinkRepository {
  final _links = <Link>[];
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
    }

    _links[i] = link;
  }
}
