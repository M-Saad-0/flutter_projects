part of 'expanse_bloc.dart';

sealed class ExpanseState extends Equatable {
  const ExpanseState();
  
  @override
  List<Object> get props => [];
}

final class ExpanseInitial extends ExpanseState {}
final class ExpanseLoading extends ExpanseState {}

final class ExpanseLoaded extends ExpanseState {
  final List<Expanse> expanses; // Replace dynamic with your Expanse model

  const ExpanseLoaded(this.expanses);

  @override
  List<Object> get props => [expanses, expanses.length];
}

final class ExpanseError extends ExpanseState {
  final String message;

  const ExpanseError(this.message);

  @override
  List<Object> get props => [message];
}