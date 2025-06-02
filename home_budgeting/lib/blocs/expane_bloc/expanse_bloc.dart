import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:home_budgeting/models/expanse.dart';
import 'package:home_budgeting/services/expanse_servcie.dart';

part 'expanse_event.dart';
part 'expanse_state.dart';

class ExpanseBloc extends Bloc<ExpanseEvent, ExpanseState> {
  ExpanseServcie expanseServcie;
  ExpanseBloc({required this.expanseServcie}) : super(ExpanseInitial()) {
    on<AddExpanse>((event, emit) async {
      try {
        Expanse expanse = await expanseServcie.addExpanse(event.expanse);
        final currentExpanses = List<Expanse>.from((state as ExpanseLoaded).expanses);

        final updatedExpanses = currentExpanses..insert(0, expanse);
        // emit(ExpanseLoading());

        emit(ExpanseLoaded(updatedExpanses));
      } catch (e) {
        emit(ExpanseError("Sorry, there was a problem"));
      }
    });

    on<UpdateExpanse>((event, emit) async {
      try {
        await expanseServcie.updateExpanse(event.expanse);
                final currentExpanses = List<Expanse>.from((state as ExpanseLoaded).expanses);

        final updatedExpanses =
            currentExpanses.map((e) {
              if (e.date == event.expanse.date) {
                return event.expanse;
              } else {
                return e;
              }
            }).toList();
        // emit(ExpanseLoading());
        emit(ExpanseLoaded(updatedExpanses));
      } catch (e) {
        debugPrint(e.toString());
        emit(ExpanseError("Sorry, there was a problem"));
      }
    });

    on<GetExpanses>((event, emit) async {
      emit(ExpanseLoading());
      try {
        List<Expanse> expanses = expanseServcie.getAllExpanses();
        expanses.sort((a, b) => DateTime.parse(b.date).compareTo(DateTime.parse(a.date)),);
        emit(ExpanseLoaded(expanses));
      } catch (e) {
        debugPrint(e.toString());
        emit(ExpanseError("Sorry, there was a problem"));
      }
    });

    on<DeleteExpanse>((event, emit) async {
      try {
        await expanseServcie.deleteExpanse(event.expanse);
                final currentExpanses = List<Expanse>.from((state as ExpanseLoaded).expanses);

        final updatedExpanses =
           currentExpanses..removeWhere((e) {
              return e.date == event.expanse.date;
            });
        // emit(ExpanseLoading());

        emit(ExpanseLoaded(updatedExpanses));
      } catch (e) {
        emit(ExpanseError("Sorry, there was a problem"));
      }
    });
  }
}
