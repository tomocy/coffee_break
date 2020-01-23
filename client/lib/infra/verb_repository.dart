import 'dart:math';

import 'package:coffee_break/domain/models/verb.dart';
import 'package:coffee_break/domain/resources/verb_repository.dart';
import 'package:coffee_break/infra/mock.dart';

class MockVerbRepository extends Mock implements VerbRepository {
  MockVerbRepository({Random randomToFail}) : super(randomToFail: randomToFail);

  final _verbs = <Verb>[
    const Verb('do', 'done'),
  ];

  Future<List<Verb>> fetch() async => !doFail
      ? _verbs
      : throw const VerbRepositoryFetchException('failed to fetch verbs');

  Future<void> save(Verb verb) {
    if (doFail) {
      throw const VerbRepositorySaveException('failed to save verb');
    }

    _verbs
      ..remove(verb)
      ..add(verb);
  }
}
