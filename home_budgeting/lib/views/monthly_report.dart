import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_budgeting/blocs/monthly_report_bloc/monthly_report_bloc.dart';
import 'package:graphic/graphic.dart';
import 'package:home_budgeting/core/constants/months.dart';
import 'package:intl/intl.dart';

class MonthlyReport extends StatefulWidget {
  const MonthlyReport({super.key});

  @override
  State<MonthlyReport> createState() => _MonthlyReportState();
}

class _MonthlyReportState extends State<MonthlyReport>
    with TickerProviderStateMixin {
  late TabController _monthTabController;
  String? selectedYear;

  @override
  void initState() {
    super.initState();
    context.read<MonthlyReportBloc>().add(CreateMonthlyReport());
    _monthTabController = TabController(length: 12, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Report")),
      body: Column(
        children: [
          BlocBuilder<MonthlyReportBloc, MonthlyReportState>(
            builder: (context, state) {
              switch (state) {
                case MonthlyReportLoading():
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10),
                        Text("Loading..."),
                      ],
                    ),
                  );

                case MonthlyReportLoaded():
                  _monthTabController = TabController(
                    length: state.report.yearTotal.keys.length,
                    vsync: this,
                  );

                  final years = state.report.yearTotal.keys.toList();
                  selectedYear = selectedYear ?? years.first;

                  final yearData =
                      (state.report.generalReport[selectedYear] as Map)
                          .cast<String, dynamic>();

               
                  return Column(
                    children: [
                      DropdownButton<String>(
                        value: selectedYear,
                        hint: const Text("Select Year"),
                        items:
                            years.map((year) {
                              return DropdownMenuItem(
                                value: year,
                                child: Text(year),
                              );
                            }).toList(),
                        onChanged: (v) {
                          if (v != null) {
                            setState(() {
                              selectedYear = v;
                            });
                          }
                        },
                      ),
                      Card(
                        margin: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            TabBar(
                              isScrollable: true,
                              controller: _monthTabController,
                              tabs:
                                  months
                                      .map((month) => Tab(text: month))
                                      .toList(),
                            ),
                            SizedBox(
                              height: 350,
                              child: TabBarView(
                                controller: _monthTabController,
                                children:
                                    months.map((monthName) {
                                      final monthData =
                                          (yearData[monthName] as List?)
                                              ?.cast<Map<String, dynamic>>();

                                      final prices =
                                          monthData
                                              ?.map(
                                                (e) => TimeSeriesSales(
                                                  DateTime.parse(e['date']),
                                                  e['price'],
                                                ),
                                              )
                                              .toList() ??
                                          <TimeSeriesSales>[];

                                      return Padding(
                                        padding: const EdgeInsets.all(16),
                                        child:
                                            prices.isEmpty
                                                ? Center(
                                                  child: Text(
                                                    "No data for $monthName",
                                                  ),
                                                )
                                                : Chart(
                                                  data: prices,
                                                  variables: {
                                                    'time': Variable(
                                                      accessor:
                                                          (
                                                            TimeSeriesSales
                                                            datum,
                                                          ) => datum.time,
                                                      scale: TimeScale(
                                                        formatter:
                                                            (time) =>
                                                                _monthDayFormat
                                                                    .format(
                                                                      time,
                                                                    ),
                                                      ),
                                                    ),
                                                    'sales': Variable(
                                                      accessor:
                                                          (
                                                            TimeSeriesSales
                                                            datum,
                                                          ) => datum.sales,
                                                    ),
                                                  },
                                                  marks: [
                                                    AreaMark(
                                                      shape: ShapeEncode(
                                                        value: BasicAreaShape(
                                                          smooth: true,
                                                        ),
                                                      ),
                                                      color: ColorEncode(
                                                        value: Defaults
                                                            .colors10
                                                            .first
                                                            .withAlpha(80),
                                                      ),
                                                    ),

                                                    LineMark(
                                                      shape: ShapeEncode(
                                                        value: BasicLineShape(
                                                          dash: [5, 2],
                                                        ),
                                                      ),
                                                      selected: {
                                                        'touchMove': {1},
                                                      },
                                                    ),
                                                    PointMark(),
                                                  ],
                                                  coord: RectCoord(
                                                    color: const Color(
                                                      0xffdddddd,
                                                    ),
                                                  ),
                                                  axes: [
                                                    Defaults.horizontalAxis,
                                                    Defaults.verticalAxis,
                                                  ],
                                                  selections: {
                                                    'touchMove': PointSelection(
                                                      on: {
                                                        GestureType.scaleUpdate,
                                                        GestureType.tapDown,
                                                        GestureType
                                                            .longPressMoveUpdate,
                                                      },
                                                      dim: Dim.x,
                                                    ),
                                                  },
                                                  tooltip: TooltipGuide(
                                                    followPointer: [
                                                      false,
                                                      true,
                                                    ],
                                                    align: Alignment.topLeft,
                                                    offset: const Offset(
                                                      -20,
                                                      -20,
                                                    ),
                                                  ),
                                                  crosshair: CrosshairGuide(
                                                    followPointer: [
                                                      false,
                                                      true,
                                                    ],
                                                  ),
                                                ),
                                      );
                                    }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );

                case MonthlyReportError():
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error, size: 50),
                        const SizedBox(height: 10),
                        Text(state.message),
                      ],
                    ),
                  );

                default:
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.info, size: 50),
                        SizedBox(height: 10),
                        Text("Nothing to create a report."),
                      ],
                    ),
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}

class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}

class MonthSeriesSales {
  final String time;
  final int sales;

  MonthSeriesSales(this.time, this.sales);
}

final DateFormat _monthDayFormat = DateFormat('MMM d'); // e.g., Jan 3
