import 'package:coffee_break/domain/models/verb.dart';
import 'package:coffee_break/domain/resources/verb_repository.dart';
import 'package:coffee_break/infra/mock.dart';

class MockVerbRepository extends Mock implements VerbRepository {
  MockVerbRepository({Failer failer}) : super(failer: failer);

  final _verbs = <Verb>[
    const Verb('do', 'done'),
  ];

  @override
  Future<List<Verb>> fetch() async =>
      !doFail ? _verbs : throw const VerbRepositoryFetchException();

  @override
  Future<void> update(Verb oldVerb, Verb newVerb) async {
    if (doFail) {
      throw VerbRepositoryUpdateException(
        oldVerb,
        newVerb,
      );
    }

    if (oldVerb == newVerb) {
      return;
    }

    try {
      await save(newVerb);
      await delete(oldVerb);
    } on VerbRepositorySaveException {
      throw VerbRepositoryUpdateException(
        oldVerb,
        newVerb,
      );
    } on VerbRepositoryDeleteException {
      await delete(newVerb);
      throw VerbRepositoryUpdateException(
        oldVerb,
        newVerb,
      );
    }
  }

  @override
  Future<void> save(Verb verb) async {
    if (doFail) {
      throw VerbRepositorySaveException(verb);
    }

    _verbs
      ..remove(verb)
      ..add(verb);
  }

  @override
  Future<void> delete(Verb verb) async =>
      !doFail ? _verbs.remove(verb) : throw VerbRepositoryDeleteException(verb);
}
