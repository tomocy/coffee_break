class Verb {
  const Verb(this.base, this.pastParticle);

  final String base;
  final String pastParticle;

  String get capitalizedBase => _capitalize(base);

  String get capitalizedPastParticle => _capitalize(pastParticle);

  String get capitalizedInfinitive => _capitalize(infinitive);

  String get infinitive => 'to $base';

  String _capitalize(String target) =>
      target[0].toUpperCase() + target.substring(1);

  @override
  bool operator ==(dynamic other) =>
      other is Verb && other.base == base && other.pastParticle == pastParticle;

  @override
  int get hashCode => base.hashCode + pastParticle.hashCode;
}
