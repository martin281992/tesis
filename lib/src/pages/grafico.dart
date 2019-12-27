import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart';

class Grafico extends StatefulWidget {
  final List<double> data;

  const Grafico({Key key, this.data}) : super(key: key);
  @override
  _GraficoState createState() => _GraficoState();
}

class _GraficoState extends State<Grafico> {
  _onSelectionChange(SelectionModel model) {
    final selectedDatum = model.selectedDatum;
    var time;
    final measure = <String, double>{};

    if (selectedDatum.isNotEmpty) {
      time = selectedDatum.first.datum;
      selectedDatum.forEach((SeriesDatum datumPair) {
        measure[datumPair.series.displayName] = datumPair.datum;
      });
    }
    print(time);
    print(measure);
  }

  @override
  Widget build(BuildContext context) {
    List<Series<double, num>> series = [
      Series<double, int>(
        id: 'Cobros',
        colorFn: (_, __) => MaterialPalette.purple.shadeDefault,
        domainFn: (value, index) => index,
        measureFn: (value, _) => value,
        data: widget.data,
        strokeWidthPxFn: (_, __) => 4,
      )
    ];

    return LineChart(
      series,
      animate: false,
      selectionModels: [
        SelectionModelConfig(
          type: SelectionModelType.info,
          changedListener: _onSelectionChange,
        ),
      ],
      domainAxis: NumericAxisSpec(
          tickProviderSpec: StaticNumericTickProviderSpec([
        TickSpec(0, label: '01'),
        TickSpec(4, label: '05'),
        TickSpec(9, label: '10'),
        TickSpec(14, label: '15'),
        TickSpec(19, label: '20'),
        TickSpec(24, label: '25'),
        TickSpec(29, label: '30'),
      ])),
      primaryMeasureAxis: NumericAxisSpec(
          tickProviderSpec: BasicNumericTickProviderSpec(
        desiredTickCount: 4,
      )),
    );
  }
}
