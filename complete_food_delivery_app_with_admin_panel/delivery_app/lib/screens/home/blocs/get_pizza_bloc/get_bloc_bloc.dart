import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pizza_repository/pizza_repository.dart';

part 'get_bloc_event.dart';
part 'get_bloc_state.dart';

class GetBlocBloc extends Bloc<GetBlocEvent, GetBlocState> {
 final PizzaRepo _pizzaRepo;
  GetBlocBloc(this._pizzaRepo) : super(GetBlocInitial()) {
    on<GetPizza>((event, emit) async{
      emit(GetBlocLoading());
      try{
        List<PizzaModels> pizzas = await _pizzaRepo.getPizza();
        emit(GetBlocSuccess(pizzas));
      }catch (e){
        emit(GetBlocFaliure());
      }
    });
  }
}
