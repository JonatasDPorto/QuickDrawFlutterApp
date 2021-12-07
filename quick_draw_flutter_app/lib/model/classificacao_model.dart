class Classificacao {
  final String nome;
  final List<double> classes;

  Classificacao._(
    this.nome,
    this.classes,
  );

  factory Classificacao.fromList(String _nome, List<double> list) {
    return Classificacao._(
      _nome,
      list,
    );
  }
}
