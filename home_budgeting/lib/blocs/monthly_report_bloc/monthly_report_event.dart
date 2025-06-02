part of 'monthly_report_bloc.dart';

sealed class MonthlyReportEvent extends Equatable {
  const MonthlyReportEvent();

  @override
  List<Object> get props => [];
}

class CreateMonthlyReport extends MonthlyReportEvent{}