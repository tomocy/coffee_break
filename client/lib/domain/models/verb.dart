class Verb {
  const Verb(this.base, this.pastParticle);

  final String base;
  final String pastParticle;

  String get capitalizedBase => base[0].toUpperCase() + base.substring(1);

  String get infinitive => 'to $base';

  @override
  bool operator ==(dynamic other) =>
      other is Verb && other.base == base && other.pastParticle == pastParticle;

  @override
  int get hashCode => base.hashCode + pastParticle.hashCode;
}
