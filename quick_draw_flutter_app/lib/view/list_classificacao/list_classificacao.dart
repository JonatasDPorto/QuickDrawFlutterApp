import 'package:flutter/material.dart';
import 'package:quick_draw_flutter_app/model/classificacao_model.dart';

class ListClassificacao extends StatefulWidget {
  final List<Classificacao> classificacoes;
  const ListClassificacao({
    Key? key,
    required this.classificacoes,
  }) : super(key: key);

  @override
  _ListClassificacaoState createState() => _ListClassificacaoState();
}

class _ListClassificacaoState extends State<ListClassificacao> {
  late List<String> labels;
  late Size size;
  late List<Color> colors;
  @override
  void initState() {
    colors = [Colors.blue, Colors.red];
    labels = [
      'Bee',
      'Coffee cup',
      'Guitar',
      'Hamburger',
      'Rabbit',
      'Truck',
      'Umbrella',
      'Crab',
      'Banana',
      'Airplane',
    ];
    super.initState();
  }

  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: size.width * .2,
          child: ListView.builder(
            itemCount: widget.classificacoes.length,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (ctx, index) {
              return Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(size.width * .02),
                    width: size.width * .05,
                    height: size.width * .05,
                    color: colors[index],
                  ),
                  SizedBox(
                    width: size.width * .25,
                    child: Text(
                      widget.classificacoes[index].nome,
                      style: TextStyle(color: colors[index]),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: labels.length,
            shrinkWrap: true,
            itemBuilder: (ctx, index) {
              return Card(
                child: SizedBox(
                  height: size.width * .2,
                  width: size.width,
                  child: Row(
                    children: [
                      Container(
                        width: size.width * .2,
                        margin: EdgeInsets.all(size.width * .025),
                        child: Text(labels[index]),
                      ),
                      SizedBox(
                        height: size.width * .25,
                        width: size.width * .7,
                        child: Center(
                          child: ListView.builder(
                            itemCount: widget.classificacoes.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (ctx2, index2) {
                              return Row(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    width: size.width *
                                        .4 *
                                        widget.classificacoes[index2]
                                            .classes[index],
                                    height: size.width * .05,
                                    color: colors[index2],
                                  ),
                                  Container(
                                    width: size.width * .25,
                                    margin: EdgeInsets.all(size.width * .01),
                                    child: Text(
                                      '${(widget.classificacoes[index2].classes[index] * 100).toStringAsFixed(1)}%',
                                      style: TextStyle(color: colors[index2]),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
