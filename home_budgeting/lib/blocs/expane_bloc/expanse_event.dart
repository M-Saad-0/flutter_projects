part of 'expanse_bloc.dart';

sealed class ExpanseEvent extends Equatable {
  const ExpanseEvent();

  @override
  List<Object> get props => [];
}

class AddExpanse extends ExpanseEvent {
  final Expanse expanse;

  const AddExpanse(this.expanse);

  @override
  List<Object> get props => [expanse];
}

class UpdateExpanse extends ExpanseEvent {
  final Expanse expanse;

  const UpdateExpanse(this.expanse);

  @override
  List<Object> get props => [expanse];
}

class DeleteExpanse extends ExpanseEvent {
  final Expanse expanse;

  const DeleteExpanse(this.expanse);

  @override
  List<Object> get props => [expanse];
}

class GetExpanses extends ExpanseEvent{}