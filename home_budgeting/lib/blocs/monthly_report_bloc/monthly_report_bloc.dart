import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:home_budgeting/models/report.dart';
import 'package:home_budgeting/services/monthly_expanse_service.dart';

part 'monthly_report_event.dart';
part 'monthly_report_state.dart';

class MonthlyReportBloc extends Bloc<MonthlyReportEvent, MonthlyReportState> {
  MonthlyExpanseService monthlyExpanseService;
  MonthlyReportBloc({required this.monthlyExpanseService})
    : super(MonthlyReportInitial()) {
    on<CreateMonthlyReport>((event, emit) async {
      emit(MonthlyReportLoading());
      try {
        final ExpanseReport? report = await monthlyExpanseService.createAReport();
        if(report==null){
          emit(MonthlyReportError(message:"No record found"));
          return;
        }
        
        emit(MonthlyReportLoaded(report: report));
      } catch (e) {
        emit(MonthlyReportError(message: e.toString()));
      }
    });
  }
}



// You need month total
// You need year total
