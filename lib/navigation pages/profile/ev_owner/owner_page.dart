import 'package:flutter/material.dart';
import 'package:ev_homegrid/constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartSampleData {
  ChartSampleData(this.xVal, this.yVal);
  final double xVal;
  final double yVal;
}

class OwnerInfo extends StatefulWidget {
  const OwnerInfo({Key? key}) : super(key: key);

  @override
  State<OwnerInfo> createState() => _EVCOwner();
}

class _EVCOwner extends State<OwnerInfo> {
  late List<ChartSampleData> _chartdata;
  late List<ChartSampleData> _hours;
  late List<ChartSampleData> _users;

  @override
  void initState() {
    _chartdata = getChartData();
    _hours = getChart1Data();
    _users = getChart2Data();

    super.initState();
  }

  List<ChartSampleData> getChartData() {
    final List<ChartSampleData> chartData = <ChartSampleData>[
      ChartSampleData(1, 78),
      ChartSampleData(2, 50),
      ChartSampleData(3, 40),
      ChartSampleData(4, 90),
      ChartSampleData(5, 10),
      ChartSampleData(6, 40),
      ChartSampleData(7, 62),
      ChartSampleData(8, 55),
      ChartSampleData(9, 102),
      ChartSampleData(10, 90),
      ChartSampleData(11, 37),
      ChartSampleData(12, 19),
      ChartSampleData(13, 85),
      ChartSampleData(14, 45),
      ChartSampleData(15, 69),
    ];
    return chartData;
  }

  List<ChartSampleData> getChart1Data() {
    final List<ChartSampleData> _hours = <ChartSampleData>[
      ChartSampleData(1, 7.8),
      ChartSampleData(2, 5),
      ChartSampleData(3, 4),
      ChartSampleData(4, 9),
      ChartSampleData(5, 1),
      ChartSampleData(6, 4),
      ChartSampleData(7, 6.2),
      ChartSampleData(8, 5.5),
      ChartSampleData(9, 10.2),
      ChartSampleData(10, 9.0),
      ChartSampleData(11, 3.7),
      ChartSampleData(12, 1.9),
      ChartSampleData(13, 8.5),
      ChartSampleData(14, 4.5),
      ChartSampleData(15, 6.9),
    ];
    return _hours;
  }

  List<ChartSampleData> getChart2Data() {
    final List<ChartSampleData> _users = <ChartSampleData>[
      ChartSampleData(1, 569),
      ChartSampleData(2, 334),
      ChartSampleData(3, 708),
      ChartSampleData(4, 119),
      ChartSampleData(5, 657),
      ChartSampleData(6, 245),
      ChartSampleData(7, 908),
      ChartSampleData(8, 467),
      ChartSampleData(9, 859),
      ChartSampleData(10, 360),
      ChartSampleData(11, 672),
      ChartSampleData(12, 856),
    ];
    return _users;
  }

  static const customSizedBox = SizedBox(
    height: 25.0,
  );

  // String? _selectedValue;
  // bool isEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'EV Charger Owner',
            style: kProfileTitleStyle,
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            ),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(kHorizontalPadding),
            child: SingleChildScrollView(
              reverse: true,
              child: Container(
                child: Column(children: [
                  Card(
                    child: Container(
                      child: SfCartesianChart(
                        title: ChartTitle(
                          text: "Energy Consumption",
                          textStyle: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        legend: Legend(
                            isVisible: true, position: LegendPosition.bottom),
                        primaryXAxis: NumericAxis(
                            title: AxisTitle(
                              text: "days",
                            ),
                            majorGridLines: MajorGridLines(width: 0),
                            axisLine: AxisLine(width: 0),
                            minimum: 0,
                            maximum: 30,
                            interval: 3,
                            crossesAt: 0,
                            placeLabelsNearAxisLine: false,
                            edgeLabelPlacement: EdgeLabelPlacement.shift),
                        primaryYAxis: NumericAxis(
                            title: AxisTitle(
                              text: "kWh",
                            ),
                            majorGridLines: MajorGridLines(width: 0),
                            axisLine: AxisLine(width: 0),
                            minimum: 0,
                            maximum: 110,
                            interval: 10,
                            crossesAt: 0,
                            placeLabelsNearAxisLine: false,
                            edgeLabelPlacement: EdgeLabelPlacement.shift),
                        series: <ChartSeries>[
                          ColumnSeries<ChartSampleData, double>(
                            color: Colors.amber,
                            name: "days x kWh",
                            dataSource: _chartdata,
                            xValueMapper: (ChartSampleData val, _) => val.xVal,
                            yValueMapper: (ChartSampleData val, _) => val.yVal,
                            dataLabelMapper: (ChartSampleData data, _) =>
                                "(${data.xVal.toString().split(".")[0] + ", " + data.yVal.toString().split(".")[0]})",
                            dataLabelSettings: DataLabelSettings(
                              isVisible: false,
                              offset: Offset(15, 5),
                              labelAlignment: ChartDataLabelAlignment.bottom,
                            ),
                            markerSettings: MarkerSettings(
                                isVisible: false, height: 10, width: 10),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Container(
                      child: SfCartesianChart(
                        title: ChartTitle(
                          text: "Hours Charger Used",
                          textStyle: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        legend: Legend(
                            isVisible: true, position: LegendPosition.bottom),
                        primaryXAxis: NumericAxis(
                            title: AxisTitle(
                              text: "days",
                            ),
                            majorGridLines: MajorGridLines(width: 0),
                            axisLine: AxisLine(width: 0),
                            minimum: 0,
                            maximum: 30,
                            interval: 3,
                            crossesAt: 0,
                            placeLabelsNearAxisLine: false,
                            edgeLabelPlacement: EdgeLabelPlacement.shift),
                        primaryYAxis: NumericAxis(
                            title: AxisTitle(
                              text: "hours",
                            ),
                            majorGridLines: MajorGridLines(width: 0),
                            axisLine: AxisLine(width: 0),
                            minimum: 0,
                            maximum: 24,
                            interval: 2,
                            crossesAt: 0,
                            placeLabelsNearAxisLine: true,
                            edgeLabelPlacement: EdgeLabelPlacement.shift),
                        series: <ChartSeries>[
                          LineSeries<ChartSampleData, double>(
                            name: "days x hours",
                            dataSource: _hours,
                            xValueMapper: (ChartSampleData val, _) => val.xVal,
                            yValueMapper: (ChartSampleData val, _) => val.yVal,
                            dataLabelMapper: (ChartSampleData data, _) =>
                                "(${data.xVal.toString().split(".")[0] + ", " + data.yVal.toString().split(".")[0]})",
                            dataLabelSettings: DataLabelSettings(
                              isVisible: false,
                              offset: Offset(15, 5),
                              labelAlignment: ChartDataLabelAlignment.bottom,
                            ),
                            markerSettings: MarkerSettings(
                                isVisible: false, height: 10, width: 10),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Container(
                      child: SfCartesianChart(
                        title: ChartTitle(
                          text: "Average Active Users Per Month",
                          textStyle: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        legend: Legend(
                            isVisible: true, position: LegendPosition.bottom),
                        primaryXAxis: NumericAxis(
                            title: AxisTitle(
                              text: "month",
                            ),
                            majorGridLines: MajorGridLines(width: 0),
                            axisLine: AxisLine(width: 0),
                            minimum: 0,
                            maximum: 13,
                            interval: 1,
                            crossesAt: 0,
                            placeLabelsNearAxisLine: false,
                            edgeLabelPlacement: EdgeLabelPlacement.shift),
                        primaryYAxis: NumericAxis(
                            title: AxisTitle(
                              text: "avg users",
                            ),
                            majorGridLines: MajorGridLines(width: 0),
                            axisLine: AxisLine(width: 0),
                            minimum: 0,
                            maximum: 1000,
                            interval: 10,
                            crossesAt: 0,
                            placeLabelsNearAxisLine: false,
                            edgeLabelPlacement: EdgeLabelPlacement.shift),
                        series: <ChartSeries>[
                          ColumnSeries<ChartSampleData, double>(
                            color: Colors.greenAccent,
                            name: "month x avg.no.of users",
                            dataSource: _users,
                            xValueMapper: (ChartSampleData val, _) => val.xVal,
                            yValueMapper: (ChartSampleData val, _) => val.yVal,
                            dataLabelMapper: (ChartSampleData data, _) =>
                                "(${data.xVal.toString().split(".")[0] + ", " + data.yVal.toString().split(".")[0]})",
                            dataLabelSettings: DataLabelSettings(
                              isVisible: false,
                              offset: Offset(15, 5),
                              labelAlignment: ChartDataLabelAlignment.bottom,
                            ),
                            markerSettings: MarkerSettings(
                                isVisible: false, height: 10, width: 10),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            )));
  }
}
