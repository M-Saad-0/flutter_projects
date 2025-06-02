class ExpanseReport {
  final Map<String, dynamic> generalReport;
  final Map<String, int> yearTotal;
  final Map<String, Map<String, int>> monthTotal;

  ExpanseReport({required this.yearTotal,required this.monthTotal, required this.generalReport});

  factory ExpanseReport.fromJson(Map<String, dynamic> gReport, Map<String, Map<String, int>> monthTotal, Map<String, int> yearTotal){
    return ExpanseReport(generalReport: gReport, yearTotal: yearTotal, monthTotal: monthTotal);
  }
}


