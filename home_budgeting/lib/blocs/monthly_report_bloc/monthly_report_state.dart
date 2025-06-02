part of 'monthly_report_bloc.dart';

sealed class MonthlyReportState extends Equatable {
  const MonthlyReportState();
  
  @override
  List<Object> get props => [];
}

final class MonthlyReportInitial extends MonthlyReportState {}
final class MonthlyReportLoading extends MonthlyReportState {}
final class MonthlyReportLoaded extends MonthlyReportState {
  final ExpanseReport report;
  const MonthlyReportLoaded({required this.report});
  @override
  List<Object> get props =>[];
}
final class MonthlyReportError extends MonthlyReportState {
  final String message;
  const MonthlyReportError({required this.message});

  @override
  List<Object> get props => [message];
}
