class Verb {
  const Verb(this.base, this.pastParticle);

  final String base;
  final String pastParticle;

  String get infinitive => 'to $base';
}