
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeThemeToggledState(Hive.box('misc').get('isDark') ?? true)) {
    on<ThemeToggleEvent>((event, emit) async{
      final box = Hive.box('misc');
      final currentTheme = box.get('isDark')??true;
      emit(ThemeThemeToggledState(!currentTheme));
      await box.put('isDark', !currentTheme);
      print(currentTheme);
    });
  }
}
