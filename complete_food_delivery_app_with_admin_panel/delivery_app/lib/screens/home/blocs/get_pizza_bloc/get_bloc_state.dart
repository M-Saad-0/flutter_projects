part of 'get_bloc_bloc.dart';

sealed class GetBlocState extends Equatable {
  const GetBlocState();
  
  @override
  List<Object> get props => [];
}

final class GetBlocInitial extends GetBlocState {}
final class GetBlocFaliure extends GetBlocState {}
final class GetBlocLoading extends GetBlocState {}
final class GetBlocSuccess extends GetBlocState {
  final List<PizzaModels> pizzas;
  const GetBlocSuccess(this.pizzas);
    @override
  List<Object> get props => [pizzas];
}
